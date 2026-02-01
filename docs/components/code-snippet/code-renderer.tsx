'use client';

import { useEffect, useState } from 'react';
import { cn } from '@/lib/utils';
import type { ProcessedLine, SnippetData } from './types';
import { collectAnnotations, processTokens } from './utils';
import { TokenGroup } from './token-span';

interface Props {
  snippet: SnippetData;
  isTooltip?: boolean;
}

export function CodeRenderer({ snippet, isTooltip = false }: Props) {
  const [processedLines, setProcessedLines] = useState<ProcessedLine[] | null>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    async function tokenize() {
      try {
        const { codeToTokensWithThemes } = await import('shiki');
        const result = await codeToTokensWithThemes(snippet.text.trim(), {
          lang: 'dart',
          themes: {
            light: 'github-light',
            dark: 'github-dark',
          },
        });

        const annotations = collectAnnotations(snippet);
        const processed = processTokens(result, annotations, snippet.highlights);
        setProcessedLines(processed);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Failed to tokenize code.');
      }
    }

    void tokenize();
  }, [snippet]);

  if (error) {
    return (
      <pre className={cn(isTooltip ? 'text-xs p-0' : 'p-4')}>
        <code>{snippet.text}</code>
      </pre>
    );
  }

  if (!processedLines) {
    const lines = snippet.text.trim().split('\n');
    return (
      <code className={cn('block bg-transparent border-0 whitespace-pre', isTooltip && 'text-xs')}>
        {lines.map((line, lineIdx) => (
          <div key={lineIdx} className="leading-relaxed">
            {!isTooltip && (
              <span className="select-none text-muted-foreground text-right pr-4 inline-block w-8">
                {lineIdx + 1}
              </span>
            )}
            <span className="animate-pulse text-muted-foreground">{line}</span>
          </div>
        ))}
      </code>
    );
  }

  return (
    <code className={cn('block bg-transparent border-0 whitespace-pre', isTooltip ? 'text-xs' : '')}>
      {processedLines.map((line, lineIdx) => (
        <div key={lineIdx} className={cn('leading-relaxed', line.highlighted && 'bg-accent/50')}>
          {!isTooltip && (
            <span className="select-none text-muted-foreground text-right pr-4 inline-block w-8">{lineIdx + 1}</span>
          )}
          {line.tokenGroups.map((group, groupIdx) => (
            <TokenGroup key={`${lineIdx}-${groupIdx}`} group={group} isTooltip={isTooltip} />
          ))}
        </div>
      ))}
    </code>
  );
}
