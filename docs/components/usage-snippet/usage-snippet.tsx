'use client';

import { useState, useMemo } from 'react';
import { cn } from '@/lib/utils';
import { CopyButton } from '@/components/ui/copy-button';
import { CodeRenderer } from '@/components/code-snippet/code-renderer';
import type { UsageSnippetData } from './types';
import { assembleSnippet } from './assemble';
import { getCategoryColor } from './colors';
import { CategoryControls } from './category-controls';

interface Props {
  usage: UsageSnippetData;
  className?: string;
}

function initSelections(usage: UsageSnippetData): Record<string, number | null> {
  const selections: Record<string, number | null> = {};
  for (const name of Object.keys(usage.categories)) {
    selections[name] = name === 'Core' ? 0 : null;
  }
  return selections;
}

export function UsageSnippet({ usage, className }: Props) {
  // Category name -> selected variant index (null represents the category is deselected).
  const [selections, setSelections] = useState(() => initSelections(usage));

  const { snippet, lineCategories } = useMemo(() => assembleSnippet(usage, selections), [usage, selections]);

  const categoryColors = useMemo(() => {
    const map = new Map<string, number>();
    let index = 0;
    for (const name of Object.keys(usage.categories)) {
      if (name === 'Core') continue; // Skip Core category.
      map.set(name, index++);
    }
    return map;
  }, [usage.categories]);

  // Convert lineCategories (line → category name) into lineClasses (line → CSS class).
  const lineClasses = useMemo(() => {
    const map = new Map<number, string>();
    for (const [line, categoryName] of lineCategories) {
      const colorIndex = categoryColors.get(categoryName);
      if (colorIndex == null) continue;
      if (selections[categoryName] == null) continue;
      map.set(line, getCategoryColor(colorIndex).lineBg);
    }
    return map;
  }, [lineCategories, categoryColors, selections]);

  return (
    <div className={cn('group rounded-2xl border bg-muted shadow', className)}>
      <CategoryControls
        categories={usage.categories}
        selections={selections}
        onSelectionsChange={setSelections}
        categoryColors={categoryColors}
      />
      <div className="relative overflow-x-auto p-2">
        <CodeRenderer snippet={snippet} lineClasses={lineClasses} />
        <CopyButton text={snippet.text} />
      </div>
    </div>
  );
}
