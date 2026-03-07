import { source } from '@/lib/source';
import type { Item } from 'fumadocs-core/page-tree';

export const revalidate = false;

export async function GET(request: Request) {
  const { protocol, host } = new URL(request.url);
  const baseUrl = `${protocol}//${host}`;
  const pages = source.getPages();
  const pageMap = new Map(pages.map((p) => [p.url, p]));

  const lines: string[] = [
    '# Forui',
    '',
    '> Beautiful, minimalistic, and platform-agnostic UI library for Flutter.',
    '',
  ];

  let afterSeparator = false;

  function renderPageItem(node: Item) {
    if (node.external) return;
    const page = pageMap.get(node.url);
    if (!page) return;
    lines.push(`- [${page.data.title}](${baseUrl}${page.url}.md): ${page.data.description}`);
  }

  for (const child of source.pageTree.children) {
    switch (child.type) {
      case 'page':
        renderPageItem(child);
        break;

      case 'separator':
        afterSeparator = true;
        lines.push('', `## ${String(child.name)}`);
        break;

      case 'folder': {
        const heading = afterSeparator ? '###' : '##';
        lines.push('', `${heading} ${String(child.name)}`, '');
        for (const item of child.children) {
          if (item.type === 'page') renderPageItem(item);
        }
        break;
      }
    }
  }

  lines.push('', '## Full Documentation', '', `- [Full documentation](${baseUrl}/docs/llms-full.txt)`);

  return new Response(lines.join('\n'), {
    headers: {
      'Content-Type': 'text/plain; charset=utf-8',
    },
  });
}
