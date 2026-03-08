import { unified } from 'unified';
import remarkParse from 'remark-parse';
import remarkMdx from 'remark-mdx';
import remarkStringify from 'remark-stringify';
import { readFile } from 'fs/promises';
import path from 'path';
import type { Root, RootContent, Code, Paragraph, Strong, Text, Blockquote, BlockContent, DefinitionContent } from 'mdast';

interface MdxJsxAttribute {
  type: string;
  name: string;
  value: string | { type: string; value: string } | null;
}

interface MdxJsxFlowElement {
  type: 'mdxJsxFlowElement';
  name: string;
  attributes: MdxJsxAttribute[];
  children: RootContent[];
}

interface MdxNode {
  type: string;
  children?: MdxNode[];
}

interface SnippetData {
  text: string;
  tooltips?: { offset: number; length: number; snippet: SnippetData }[];
}

/** Extracts a string attribute value from an MDX JSX element by name. */
function getAttr(node: MdxJsxFlowElement, name: string): string | null {
  const attr = node.attributes.find((a) => a.name === name);
  if (!attr) return null;
  if (typeof attr.value === 'string') return attr.value;
  if (attr.value && typeof attr.value === 'object' && 'value' in attr.value) return attr.value.value;
  return null;
}

/** Extracts child `<Tab>` elements from a `<Tabs>` node, returning their labels and children. */
function getTabChildren(tabsNode: MdxJsxFlowElement): { label: string; children: RootContent[] }[] {
  return tabsNode.children
    .filter((c) => (c as MdxJsxFlowElement).name === 'Tab')
    .map((tab) => ({
      label: getAttr(tab as MdxJsxFlowElement, 'value') ?? '',
      children: (tab as MdxJsxFlowElement).children,
    }));
}

/** Type guard: checks if a node is an MDX JSX flow element with a specific tag name. */
function isJsxElement(node: RootContent, name: string): node is MdxJsxFlowElement & RootContent {
  return node.type === 'mdxJsxFlowElement' && (node as MdxJsxFlowElement).name === name;
}

/** Creates a fenced code block AST node (defaults to Dart). */
function makeCodeBlock(value: string, lang = 'dart'): Code {
  return { type: 'code', lang, value };
}

/** Creates a plain text AST node. */
function makeText(value: string): Text {
  return { type: 'text', value };
}

/** Creates a bold/strong AST node. */
function makeBold(value: string): Strong {
  return { type: 'strong', children: [makeText(value)] };
}

/** Reads and parses a snippet JSON file from disk, looked up by import variable name. */
async function loadSnippet(varName: string, snippetMap: Map<string, string>): Promise<SnippetData | null> {
  const filePath = snippetMap.get(varName);
  if (!filePath) return null;
  try {
    const content = await readFile(filePath, 'utf-8');
    return JSON.parse(content) as SnippetData;
  } catch {
    console.warn(`[llm-text] Failed to load snippet: ${filePath}`);
    return null;
  }
}

/** Removes YAML frontmatter from the beginning of an MDX file. */
function stripFrontmatter(raw: string): string {
  const match = raw.match(/^---\n[\s\S]*?\n---\n/);
  return match ? raw.slice(match[0].length) : raw;
}

/**
 * Scans ESM import nodes for `@/snippets/*.json` imports and builds a map from variable name to
 * file path.
 *
 * Uses regex because mdxjsEsm nodes store imports as raw strings, not structured AST.
 */
function buildSnippetMap(tree: Root, docsRoot: string): Map<string, string> {
  const map = new Map<string, string>();
  for (const node of tree.children) {
    if (node.type !== 'mdxjsEsm') continue;
    const re = /import\s+(\w+)\s+from\s+['"]@\/snippets\/(.+?\.json)['"]/g;
    let m;
    while ((m = re.exec(node.value)) !== null) {
      map.set(m[1], path.join(docsRoot, 'snippets', m[2]));
    }
  }
  return map;
}

/** Converts a `<CodeSnippet>` JSX element into a Dart code block by loading its referenced snippet. */
async function transformCodeSnippet(node: MdxJsxFlowElement, snippetMap: Map<string, string>): Promise<RootContent[]> {
  const varName = getAttr(node, 'snippet');
  if (!varName) return [];
  const snippet = await loadSnippet(varName, snippetMap);
  if (!snippet) return [makeCodeBlock('[Code snippet unavailable]', '')];
  return [makeCodeBlock(snippet.text)];
}

/** Converts a `<UsageSnippet>` JSX element into a code block, preferring the first tooltip's signature. */
async function transformUsageSnippet(
  node: MdxJsxFlowElement,
  snippetMap: Map<string, string>,
): Promise<RootContent[]> {
  const varName = getAttr(node, 'usage');
  if (!varName) return [];
  const snippet = await loadSnippet(varName, snippetMap);
  if (!snippet) return [makeCodeBlock('[Usage snippet unavailable]', '')];
  const sig = snippet.tooltips?.[0]?.snippet?.text;
  return [makeCodeBlock(sig ?? snippet.text)];
}

/** Converts a `<Callout>` JSX element into a blockquote with a bold type label (e.g. **Warning:**). Handles JSX children (e.g. CodeSnippet) by recursively transforming them. */
async function transformCallout(node: MdxJsxFlowElement, snippetMap: Map<string, string>): Promise<RootContent[]> {
  const calloutType = getAttr(node, 'type') ?? 'info';
  const label = calloutType.charAt(0).toUpperCase() + calloutType.slice(1);

  const blockquoteChildren: Array<BlockContent | DefinitionContent> = [];
  let isFirst = true;

  for (const child of node.children) {
    if (child.type === 'paragraph') {
      if (isFirst) {
        blockquoteChildren.push({
          type: 'paragraph',
          children: [makeBold(`${label}:`), makeText(' '), ...child.children],
        } as Paragraph);
        isFirst = false;
      } else {
        blockquoteChildren.push(child as Paragraph);
      }
    } else if (child.type === 'mdxJsxFlowElement') {
      const transformed = await transformJSX(child, snippetMap);
      for (const t of transformed) {
        blockquoteChildren.push(t as BlockContent);
      }
    } else {
      blockquoteChildren.push(child as BlockContent);
    }
  }

  const blockquote: Blockquote = { type: 'blockquote', children: blockquoteChildren };
  return [blockquote];
}

/**
 * Converts a `<Tabs>` JSX element. For Preview/Code pairs, emits only the code.
 *
 * Otherwise, emits each tab's content under a bold label.
 */
async function transformTabs(node: MdxJsxFlowElement, snippetMap: Map<string, string>): Promise<RootContent[]> {
  const tabs = getTabChildren(node);

  // Special case: Preview + Code tabs — only emit the code.
  if (tabs.length === 2) {
    const previewTab = tabs.find((t) => t.label === 'Preview');
    const codeTab = tabs.find((t) => t.label === 'Code');
    if (previewTab && codeTab) {
      // The code tab should contain a CodeSnippet.
      const codeChild = codeTab.children.find((c) => isJsxElement(c, 'CodeSnippet'));
      if (codeChild) {
        return transformCodeSnippet(codeChild, snippetMap);
      }
    }
  }

  // General case: emit each tab's content with a bold label.
  const result: RootContent[] = [];
  for (const tab of tabs) {
    result.push({ type: 'paragraph', children: [makeBold(tab.label)] } as Paragraph);
    for (const child of tab.children) {
      if (isJsxElement(child, 'CodeSnippet')) {
        result.push(...(await transformCodeSnippet(child, snippetMap)));
      } else if (isJsxElement(child, 'Widget')) {
        // Drop widget previews.
      } else {
        result.push(child);
      }
    }
  }
  return result;
}

/** Converts an `<Accordion>` JSX element into a bold title paragraph followed by the accordion's children. */
async function transformAccordion(node: MdxJsxFlowElement, snippetMap: Map<string, string>): Promise<RootContent[]> {
  const title = getAttr(node, 'title');
  const result: RootContent[] = [];
  if (title) {
    result.push({ type: 'paragraph', children: [makeBold(title)] } as Paragraph);
  }
  for (const child of node.children) {
    result.push(...(await transformJSX(child, snippetMap)));
  }
  return result;
}

/** Routes a top-level MDX JSX element to the appropriate transform function, dropping unknown elements. */
async function transformJSX(node: RootContent, snippetMap: Map<string, string>): Promise<RootContent[]> {
  const jsx = node as MdxJsxFlowElement;
  if (jsx.type !== 'mdxJsxFlowElement') return [node];

  switch (jsx.name) {
    case 'Tabs':
      return transformTabs(jsx, snippetMap);
    case 'CodeSnippet':
      return transformCodeSnippet(jsx, snippetMap);
    case 'UsageSnippet':
      return transformUsageSnippet(jsx, snippetMap);
    case 'Callout':
      return transformCallout(jsx, snippetMap);
    case 'Accordion':
      return transformAccordion(jsx, snippetMap);
    case 'Widget':
    case 'Tab':
      return []; // Drop standalone widgets/tabs
    default: {
      const result: RootContent[] = [];
      for (const child of jsx.children) {
        result.push(...(await transformJSX(child, snippetMap)));
      }
      return result;
    }
  }
}

/** Recursively removes MDX artifacts such as import statements, inline JSX (replaced with text children), and MDX
 * expressions.
 */
function stripInlineMdx(node: MdxNode): void {
  if (!node.children) return;
  const newChildren = [];
  for (const child of node.children) {
    if (child.type === 'mdxJsxTextElement') {
      if (child.children) {
        for (const grandchild of child.children) {
          stripInlineMdx(grandchild);
          newChildren.push(grandchild);
        }
      }
    } else if (child.type === 'mdxTextExpression' || child.type === 'mdxFlowExpression' || child.type === 'mdxjsEsm') {
      // Drop MDX expressions and import statements.
    } else {
      stripInlineMdx(child);
      newChildren.push(child);
    }
  }
  node.children = newChildren;
}

/**
 * Main entry point. Converts raw MDX into clean Markdown by stripping frontmatter/imports,
 * transforming JSX components into standard Markdown, and removing inline MDX.
 */
export async function transformMdxToLLMText(rawMdx: string, docsRoot: string): Promise<string> {
  const stripped = stripFrontmatter(rawMdx);
  const tree = unified().use(remarkParse).use(remarkMdx).parse(stripped);

  const snippetMap = buildSnippetMap(tree, docsRoot);

  // Transform JSX elements.
  const newChildren: RootContent[] = [];
  for (const node of tree.children) {
    const transformed = await transformJSX(node, snippetMap);
    newChildren.push(...transformed);
  }
  tree.children = newChildren;

  // Strip any remaining inline MDX nodes.
  stripInlineMdx(tree);

  const result = unified().use(remarkStringify, { bullet: '-', fences: true }).stringify(tree);
  return String(result).trim();
}
