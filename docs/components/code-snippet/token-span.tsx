'use client';

import { HoverCard, HoverCardContent, HoverCardTrigger } from '@/components/ui/hover-card';
import { TooltipContent } from './tooltip-content';
import type { TokenGroup as TokenGroupType } from './types';

interface Props {
  group: TokenGroupType;
  isTooltip: boolean;
}

export function TokenGroup({ group, isTooltip }: Props) {
  const { tokens, annotations } = group;
  const linkAnnotation = annotations.find((a) => a.type === 'link');
  const tooltipAnnotation = annotations.find((a) => a.type === 'tooltip');

  let element = (
    <span>
      {tokens.map((token, i) => (
        <span
          key={i}
          style={{
            ['--shiki-light' as string]: token.variants.light?.color,
            ['--shiki-dark' as string]: token.variants.dark?.color,
          }}
          className="text-(--shiki-light) dark:text-(--shiki-dark)"
        >
          {token.content}
        </span>
      ))}
    </span>
  );

  if (linkAnnotation?.url) {
    element = (
      <a
        href={linkAnnotation.url}
        target="_blank"
        rel="noopener noreferrer"
        className="underline decoration-dotted hover:decoration-muted-foreground/50 data-[state=open]:decoration-muted-foreground/50"
      >
        {element}
      </a>
    );
  }

  if (tooltipAnnotation?.snippet && !isTooltip) {
    element = (
      <HoverCard openDelay={200} closeDelay={100}>
        <HoverCardTrigger asChild>{element}</HoverCardTrigger>
        <HoverCardContent className="w-auto p-3" side="top" align="start">
          <TooltipContent snippet={tooltipAnnotation.snippet} />
        </HoverCardContent>
      </HoverCard>
    );
  }

  return element;
}
