import { source } from '@/lib/source';
import { DocsBody, DocsDescription, DocsPage, DocsTitle } from 'fumadocs-ui/layouts/docs/page';
import { notFound } from 'next/navigation';
import { getMDXComponents } from '@/mdx-components';
import type { Metadata } from 'next';
import { createRelativeLink } from 'fumadocs-ui/mdx';
import { Separator } from '@/components/ui/separator';
import LinkBadge from '@/components/ui/link-badge/link-badge';
import LinkBadgeGroup from '@/components/ui/link-badge/link-badge-group';

type Params = Promise<{ lang: string; slug?: string[] }>;

export default async function Page(props: { params: Params }) {
  const { lang, slug } = await props.params;
  const page = source.getPage(slug, lang);
  if (!page) notFound();

  const MDX = page.data.body;

  return (
    <DocsPage toc={page.data.toc} full={page.data.full} tableOfContent={{ style: 'clerk' }}>
      <div className="space-y-0.5">
        <DocsTitle className="">{page.data.title}</DocsTitle>
        <DocsDescription className="text-base mb-0">{page.data.description}</DocsDescription>
        {page.data.apiReference && (
          <LinkBadgeGroup className="pt-2">
            <LinkBadge label="API Reference" href={page.data.apiReference} />
          </LinkBadgeGroup>
        )}
        <Separator className="mt-2 mb-6" />
      </div>
      <DocsBody className="text-base!">
        <MDX
          components={getMDXComponents({
            a: createRelativeLink(source, page),
          })}
        />
      </DocsBody>
    </DocsPage>
  );
}

export async function generateStaticParams() {
  return source.generateParams('slug', 'lang');
}

export async function generateMetadata(props: { params: Params }): Promise<Metadata> {
  const { lang, slug } = await props.params;
  const page = source.getPage(slug, lang);
  if (!page) notFound();

  return {
    title: page.data.title,
    description: page.data.description,
  };
}
