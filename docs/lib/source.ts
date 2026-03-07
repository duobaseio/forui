import { docs } from 'fumadocs-mdx:collections/server';
import { type InferPageType, loader } from 'fumadocs-core/source';
import { lucideIconsPlugin } from 'fumadocs-core/source/lucide-icons';
import path from 'path';
import { fileURLToPath } from 'node:url';
import { transformMdxToLLMText } from './llm-text';

// See https://fumadocs.dev/docs/headless/source-api for more info
export const source = loader({
  baseUrl: '/docs',
  source: docs.toFumadocsSource(),
  plugins: [lucideIconsPlugin()],
});

const docsRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');

export async function getLLMText(page: InferPageType<typeof source>) {
  const raw = await page.data.getText('raw');
  const transformed = await transformMdxToLLMText(raw, docsRoot);

  return `# ${page.data.title}

${transformed}`;
}
