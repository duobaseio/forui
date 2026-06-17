import type { MetadataRoute } from 'next';
import { source } from '@/lib/source';
import { siteUrl } from '@/lib/site';

export default function sitemap(): MetadataRoute.Sitemap {
  const docs = source.getPages().map((page) => ({
    url: `${siteUrl}${page.url}`,
  }));

  // Non-MDX pages must be added manually.
  const pages = ['', '/enterprise'].map((path) => ({
    url: `${siteUrl}${path}`,
  }));

  return [...pages, ...docs];
}
