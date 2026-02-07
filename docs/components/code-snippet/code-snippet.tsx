'use client';

import { cn } from '@/lib/utils';
import { CopyButton } from '@/components/ui/copy-button';
import { CodeRenderer } from './code-renderer';
import type { SnippetData } from './types';

export type { SnippetData } from './types';

interface Props {
  snippet: SnippetData;
  className?: string;
}

export function CodeSnippet({ snippet, className }: Props) {
  return (
    <div className={cn('group relative rounded-2xl border bg-muted shadow', className)}>
      <div className="overflow-x-auto p-2">
        <CodeRenderer snippet={snippet} />
      </div>
      <CopyButton text={snippet.text} />
    </div>
  );
}
