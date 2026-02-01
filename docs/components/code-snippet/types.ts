import type { ThemedTokenWithVariants } from 'shiki';

export interface SnippetData {
  text: string;
  highlights: { start: number; end: number }[];
  links: { offset: number; length: number; url: string }[];
  tooltips: { offset: number; length: number; snippet: SnippetData }[];
  container?: { name: string; url: string };
}

export interface Annotation {
  offset: number;
  length: number;
  type: 'link' | 'tooltip';
  url?: string;
  snippet?: SnippetData;
}

export interface TokenGroup {
  tokens: ThemedTokenWithVariants[];
  annotations: Annotation[];
}

export interface ProcessedLine {
  tokenGroups: TokenGroup[];
  highlighted: boolean;
}
