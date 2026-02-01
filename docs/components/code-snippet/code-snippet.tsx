'use client';

import { useState, useCallback } from 'react';
import { Check, Clipboard } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { cn } from '@/lib/utils';
import { CodeRenderer } from './code-renderer';
import type { SnippetData } from './types';

export type { SnippetData } from './types';

interface Props {
  snippet: SnippetData;
  className?: string;
}

export function CodeSnippet({ snippet, className }: Props) {
  const [copied, setCopied] = useState(false);

  const handleCopy = useCallback(async () => {
    await navigator.clipboard.writeText(snippet.text);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  }, [snippet.text]);

  return (
    <div className={cn('group relative rounded-2xl border bg-muted shadow', className)}>
      <div className="overflow-x-auto p-2">
        <CodeRenderer snippet={snippet} />
      </div>
      <Button
        variant="ghost"
        size="icon-sm"
        onClick={handleCopy}
        className="absolute right-1 top-1 opacity-0 group-hover:opacity-70 transition-opacity"
        aria-label={copied ? 'Copied!' : 'Copy code'}
      >
        {copied ? <Check /> : <Clipboard />}
      </Button>
    </div>
  );
}
