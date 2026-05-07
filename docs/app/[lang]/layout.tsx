import { RootProvider } from 'fumadocs-ui/provider/next';
import { GoogleAnalytics } from '@next/third-parties/google';
import '../global.css';
import { Inter } from 'next/font/google';
import type { Metadata } from 'next';
import type { ReactNode } from 'react';
import { i18nUI } from '@/lib/i18n';

const descriptions: Record<string, string> = {
  en: 'Beautiful, minimalistic, and platform-agnostic UI library for Flutter.',
  zh: '一个为 Flutter 设计的精美、极简、平台无关的 UI 库。',
  de: 'Eine schöne, minimalistische und plattformunabhängige UI-Bibliothek für Flutter.',
};

export async function generateMetadata({
  params,
}: {
  params: Promise<{ lang: string }>;
}): Promise<Metadata> {
  const { lang } = await params;
  return {
    metadataBase: new URL('https://forui.dev'),
    title: { default: 'Forui', template: '%s | Forui' },
    description: descriptions[lang] ?? descriptions.en,
    openGraph: { images: '/banners/banner-text-130226.png' },
    icons: { icon: '/favicon.ico' },
  };
}

const inter = Inter({
  subsets: ['latin'],
});

export default async function Layout({
  children,
  params,
}: {
  children: ReactNode;
  params: Promise<{ lang: string }>;
}) {
  const { lang } = await params;
  return (
    <html lang={lang} className={inter.className} suppressHydrationWarning>
      <body className="flex flex-col min-h-screen">
        <RootProvider i18n={i18nUI.provider(lang)}>{children}</RootProvider>
      </body>
      {process.env.NEXT_PUBLIC_GA_MEASUREMENT_ID && (
        <GoogleAnalytics gaId={process.env.NEXT_PUBLIC_GA_MEASUREMENT_ID} />
      )}
    </html>
  );
}
