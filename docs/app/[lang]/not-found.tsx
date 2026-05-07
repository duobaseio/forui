'use client';

import Link from 'next/link';
import { useParams } from 'next/navigation';
import { FileQuestion } from 'lucide-react';
import { Empty, EmptyMedia, EmptyHeader, EmptyTitle, EmptyDescription } from '@/components/ui/empty';
import { Button } from '@/components/ui/button';

const messages = {
  en: {
    title: "That's Embarrassing",
    description: "The page you're looking for doesn't exist or has been moved.",
    home: 'Return Home',
  },
  zh: {
    title: '有点尴尬',
    description: '你要找的页面不存在，或者已被移动。',
    home: '返回首页',
  },
  de: {
    title: 'Das ist peinlich',
    description: 'Die gesuchte Seite existiert nicht oder wurde verschoben.',
    home: 'Zur Startseite',
  },
} as const;

type Lang = keyof typeof messages;

export default function NotFound() {
  const params = useParams<{ lang?: string }>();
  const lang = (params.lang && params.lang in messages ? params.lang : 'en') as Lang;
  const text = messages[lang];

  return (
    <main className="flex h-dvh items-center justify-center">
      <Empty>
        <EmptyHeader>
          <EmptyMedia variant="icon">
            <FileQuestion />
          </EmptyMedia>
          <EmptyTitle>{text.title}</EmptyTitle>
          <EmptyDescription>{text.description}</EmptyDescription>
        </EmptyHeader>
        <Button asChild>
          <Link href={`/${lang}`}>{text.home}</Link>
        </Button>
      </Empty>
    </main>
  );
}
