import type { SnippetData } from '@/components/code-snippet/types';

export interface CategoryVariant {
  name: string;
  description: string;
  text: string;
  highlights: { start: number; end: number }[];
  links: { offset: number; length: number; url: string }[];
  tooltips: { offset: number; length: number; snippet: SnippetData }[];
}

export interface UsageSnippetData extends SnippetData {
  categories: Record<string, CategoryVariant[]>;
}
