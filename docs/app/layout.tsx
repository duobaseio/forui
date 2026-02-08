import { RootProvider } from 'fumadocs-ui/provider/next';
import './global.css';
import { Inter } from 'next/font/google';

export const metadata = {
  metadataBase: new URL('https://forui.dev'),
  title: {
    default: 'Forui',
    template: '%s | Forui',
  },
  description: 'Beautiful, minimalistic, and platform-agnostic UI library for Flutter.',
  openGraph: {
    images: '/banners/banner-311225.png',
  },
  icons: {
    icon: '/favicon.ico',
  },
};

const inter = Inter({
  subsets: ['latin'],
});

export default function Layout({ children }: LayoutProps<'/'>) {
  return (
    <html lang="en" className={inter.className} suppressHydrationWarning>
      <body className="flex flex-col min-h-screen">
        <RootProvider>{children}</RootProvider>
      </body>
    </html>
  );
}
