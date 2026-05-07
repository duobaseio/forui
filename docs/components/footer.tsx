import { t } from '@/lib/i18n';

export function Footer({ lang }: { lang: string }) {
  const text = t(lang).footer;
  return (
    <footer className="py-6 text-center text-sm text-muted-foreground">
      {text.builtBy}{' '}
      <a
        href="https://duobase.io"
        target="_blank"
        rel="noopener noreferrer"
        className="underline hover:text-foreground"
      >
        Duobase
      </a>{' '}
      {text.fromSingapore}
    </footer>
  );
}
