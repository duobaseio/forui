'use client';

import type { SnippetData } from './types';
import { CodeRenderer } from './code-renderer';

interface Props {
  snippet: SnippetData;
}

export function TooltipContent({ snippet }: Props) {
  return (
    <div className="max-w-lg max-h-80 overflow-auto">
      {snippet.container && (
        <div className="mb-2">
          <a
            href={snippet.container.url}
            target="_blank"
            rel="noopener noreferrer"
            className="font-semibold underline"
          >
            {snippet.container.name}
          </a>
        </div>
      )}
      <CodeRenderer snippet={snippet} isTooltip />
    </div>
  );
}
