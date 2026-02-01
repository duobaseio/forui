'use client';

import type { SnippetData } from './types';
import { CodeRenderer } from './code-renderer';

interface Props {
  snippet: SnippetData;
}

export function TooltipContent({ snippet }: Props) {
  return (
    <div className="max-w-md">
      {snippet.container && (
        <div className="mb-2">
          <a
            href={snippet.container.url}
            target="_blank"
            rel="noopener noreferrer"
            className="font-semibold hover:underline"
          >
            {snippet.container.name}
          </a>
        </div>
      )}
      <CodeRenderer snippet={snippet} isTooltip />
    </div>
  );
}
