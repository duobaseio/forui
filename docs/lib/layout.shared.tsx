import type { BaseLayoutProps } from 'fumadocs-ui/layouts/shared';
import Image from 'next/image';
import { Logo } from '@/components/logo';
import { t } from '@/lib/i18n';

const iconLinks = [
  {
    type: 'icon' as const,
    label: 'GitHub',
    icon: <Image src="/brands/github.svg" alt="" width={19} height={19} className="dark:invert" />,
    text: 'GitHub',
    url: 'https://github.com/duobaseio/forui',
  },
  {
    type: 'icon' as const,
    label: 'X',
    icon: <Image src="/brands/x.svg" alt="" width={16} height={16} className="dark:invert" />,
    text: 'X',
    url: 'https://x.com/foruidev',
  },
  {
    type: 'icon' as const,
    label: 'Discord',
    icon: <Image src="/brands/discord.svg" alt="" width={22} height={22} className="dark:invert" />,
    text: 'Discord',
    url: 'https://discord.gg/jrw3qHksjE',
  },
];

// For home layout.
export function baseOptions(lang: string): BaseLayoutProps {
  const nav = t(lang).nav;
  return {
    i18n: true,
    nav: {
      title: <Logo />,
    },
    links: [
      {
        text: nav.docs,
        url: `/${lang}/docs`,
        secondary: false,
      },
      {
        text: nav.enterprise,
        url: `/${lang}/enterprise`,
        secondary: false,
      },
      ...iconLinks,
    ],
  };
}

// For docs layout.
export function docsOptions(lang: string): BaseLayoutProps {
  const nav = t(lang).nav;
  return {
    i18n: true,
    nav: {
      title: <Logo />,
    },
    links: [
      {
        text: nav.home,
        url: `/${lang}`,
        secondary: false,
      },
      {
        text: nav.enterprise,
        url: `/${lang}/enterprise`,
        secondary: false,
      },
      ...iconLinks,
    ],
  };
}
