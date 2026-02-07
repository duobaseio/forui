import type { SnippetData } from '@/components/code-snippet/types';
import type { CategoryVariant, UsageSnippetData } from './types';

const PLACEHOLDER_RE = /\{\{(\w+)\}\}/g;

interface Insertion {
  originalIndex: number;
  offset: number;
  text: string;
  name: string;
  variant: CategoryVariant | null;
}

export interface AssembledSnippet {
  snippet: SnippetData;
  lineCategories: Map<number, string>;
}

export function assembleSnippet(
  usage: UsageSnippetData,
  selections: Record<string, number | null>,
): AssembledSnippet {
  const links: { offset: number; length: number; url: string }[] = [];
  const tooltips: { offset: number; length: number; snippet: SnippetData }[] = [];
  const highlights: { start: number; end: number }[] = [];

  const placeholders: { name: string; index: number; length: number }[] = [];
  let match: RegExpExecArray | null;
  while ((match = PLACEHOLDER_RE.exec(usage.text)) !== null) {
    placeholders.push({ name: match[1], index: match.index, length: match[0].length });
  }

  let assembled = '';
  let prevEnd = 0;
  const insertions: Insertion[] = [];

  for (const ph of placeholders) {
    assembled += usage.text.slice(prevEnd, ph.index);

    const offset = assembled.length;
    const variantIndex = selections[ph.name];
    const variants = usage.categories[ph.name];
    const variant = variantIndex != null && variants?.[variantIndex] ? variants[variantIndex] : null;

    assembled += variant?.text ?? '';
    insertions.push({ originalIndex: ph.index, offset, text: variant?.text ?? '', name: ph.name, variant });

    prevEnd = ph.index + ph.length;
  }

  assembled += usage.text.slice(prevEnd);

  // Shift base links/tooltips/highlights by cumulative delta.
  for (const link of usage.links) {
    links.push({ ...link, offset: link.offset + deltaAt(link.offset, placeholders, insertions) });
  }
  for (const tooltip of usage.tooltips) {
    tooltips.push({ ...tooltip, offset: tooltip.offset + deltaAt(tooltip.offset, placeholders, insertions) });
  }
  for (const h of usage.highlights) {
    const lineDelta = lineDeltaAt(h.start, placeholders, insertions, usage.text);
    highlights.push({ start: h.start + lineDelta, end: h.end + lineDelta });
  }

  // Add each active variant's links/tooltips/highlights.
  for (const ins of insertions) {
    if (!ins.variant) continue;

    for (const link of ins.variant.links) {
      links.push({ ...link, offset: link.offset + ins.offset });
    }
    for (const tooltip of ins.variant.tooltips) {
      tooltips.push({ ...tooltip, offset: tooltip.offset + ins.offset });
    }
    for (const h of ins.variant.highlights) {
      const linesBefore = countNewlines(assembled, 0, ins.offset);
      highlights.push({ start: h.start + linesBefore, end: h.end + linesBefore });
    }
  }

  // Build lineCategories map.
  const lineCategories = new Map<number, string>();
  for (const ins of insertions) {
    if (ins.name === 'Core' || ins.text.length === 0) continue;

    const startLine = countNewlines(assembled, 0, ins.offset);
    const insertedNewlines = countNewlines(ins.text, 0, ins.text.length);

    // Check if a trailing newline is a line terminator or new line.
    const lineCount = ins.text.endsWith('\n') ? insertedNewlines : insertedNewlines + 1;
    for (let i = 0; i < lineCount; i++) {
      lineCategories.set(startLine + i, ins.name);
    }
  }

  return {
    snippet: { text: assembled, links, tooltips, highlights },
    lineCategories,
  };
}

/** Compute the character offset delta at a given position in the original template. */
function deltaAt(
  offset: number,
  placeholders: { name: string; index: number; length: number }[],
  insertions: Insertion[],
): number {
  let d = 0;
  for (let i = 0; i < placeholders.length; i++) {
    if (placeholders[i].index >= offset) break;
    d += insertions[i].text.length - placeholders[i].length;
  }
  return d;
}

/** Compute the line offset delta at a given line in the original template. */
function lineDeltaAt(
  line: number,
  placeholders: { name: string; index: number; length: number }[],
  insertions: Insertion[],
  originalText: string,
): number {
  let d = 0;
  for (let i = 0; i < placeholders.length; i++) {
    const lineOfPlaceholder = countNewlines(originalText, 0, placeholders[i].index);
    if (lineOfPlaceholder >= line) break;
    const placeholderNewlines = countNewlines(originalText, placeholders[i].index, placeholders[i].index + placeholders[i].length);
    const insertionNewlines = countNewlines(insertions[i].text, 0, insertions[i].text.length);
    d += insertionNewlines - placeholderNewlines;
  }
  return d;
}

function countNewlines(text: string, start: number, end: number): number {
  let count = 0;
  for (let i = start; i < end; i++) {
    if (text[i] === '\n') count++;
  }
  return count;
}
