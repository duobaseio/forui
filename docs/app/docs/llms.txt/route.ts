import { source } from '@/lib/source';

export const revalidate = false;

export async function GET() {
  const pages = source.getPages();

  const lines = [
    '# Forui',
    '',
    '> Beautiful, minimalistic, and platform-agnostic UI library for Flutter.',
    '',
    '## Documentation Pages',
    '',
    ...pages.map((page) => `- [${page.data.title}](https://forui.dev${page.url}.md): ${page.data.description}`),
    '',
    '## Full Documentation',
    '',
    '- [Full documentation](https://forui.dev/docs/llms-full.txt)',
  ];

  return new Response(lines.join('\n'), {
    headers: {
      'Content-Type': 'text/plain; charset=utf-8',
    },
  });
}
