'use client';

import { useState, useCallback } from 'react';
import { Check, Clipboard } from 'lucide-react';
import { cn } from '@/lib/utils';
import { Button } from '@/components/ui/button';

interface Props {
  text: string;
  className?: string;
}

export function CopyButton({ text, className }: Props) {
  const [copied, setCopied] = useState(false);

  const handleCopy = useCallback(async () => {
    await navigator.clipboard.writeText(text);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  }, [text]);

  return (
    <Button
      variant="ghost"
      size="icon-sm"
      onClick={handleCopy}
      className={cn('absolute right-1 top-1 opacity-0 group-hover:opacity-70 transition-opacity', className)}
      aria-label={copied ? 'Copied!' : 'Copy code'}
    >
      {copied ? <Check /> : <Clipboard />}
    </Button>
  );
}
