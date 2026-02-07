'use client';

import { cn } from '@/lib/utils';
import {
  DropdownMenu,
  DropdownMenuTrigger,
  DropdownMenuContent,
  DropdownMenuRadioGroup,
  DropdownMenuRadioItem,
  DropdownMenuSeparator,
} from '@/components/ui/dropdown-menu';
import { ChevronDown } from 'lucide-react';
import { getCategoryColor } from './colors';
import type { CategoryVariant } from './types';

interface Props {
  categories: Record<string, CategoryVariant[]>;
  selections: Record<string, number | null>;
  onSelectionsChange: (selections: Record<string, number | null>) => void;
  categoryColors: Map<string, number>;
}

function stripBackticks(name: string): string {
  return name.replace(/`/g, '');
}

export function CategoryControls({ categories, selections, onSelectionsChange, categoryColors }: Props) {
  const toggleableCategories = Object.entries(categories).filter(([name]) => name !== 'Core');

  if (toggleableCategories.length === 0) return null;

  return (
    <div className="flex flex-wrap items-center gap-2 border-b px-3 py-2">
      {toggleableCategories.map(([name, variants]) => {
        const isOn = selections[name] != null;
        const colorIndex = categoryColors.get(name);
        const color = colorIndex != null ? getCategoryColor(colorIndex) : undefined;

        if (variants.length > 1) {
          const selectedIndex = selections[name];
          const selectedVariant = selectedIndex != null ? variants[selectedIndex] : null;

          return (
            <DropdownMenu key={name}>
              <DropdownMenuTrigger asChild>
                <button
                  className={cn(
                    'inline-flex items-center gap-1 rounded-md border px-2.5 py-1.5 text-xs font-medium transition-colors',
                    'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring',
                    isOn && color
                      ? [color.lineBg, color.border, color.text]
                      : 'border-input bg-transparent text-muted-foreground hover:bg-accent hover:text-accent-foreground',
                  )}
                >
                  {isOn && selectedVariant ? (
                    <>
                      <span>{name}</span>
                      <span className="opacity-30">|</span>
                      <span>{stripBackticks(selectedVariant.name)}</span>
                    </>
                  ) : (
                    <span>{name}</span>
                  )}
                  <ChevronDown className="size-3 opacity-50" />
                </button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="start">
                <DropdownMenuRadioGroup
                  value={selectedIndex != null ? String(selectedIndex) : 'none'}
                  onValueChange={(value) => {
                    onSelectionsChange({
                      ...selections,
                      [name]: value === 'none' ? null : Number(value),
                    });
                  }}
                >
                  <DropdownMenuRadioItem value="none" className="text-xs">
                    None
                  </DropdownMenuRadioItem>
                  <DropdownMenuSeparator />
                  {variants.map((variant, i) => (
                    <DropdownMenuRadioItem key={i} value={String(i)} className="text-xs">
                      {stripBackticks(variant.name)}
                    </DropdownMenuRadioItem>
                  ))}
                </DropdownMenuRadioGroup>
              </DropdownMenuContent>
            </DropdownMenu>
          );
        }

        return (
          <button
            key={name}
            onClick={() => {
              onSelectionsChange({ ...selections, [name]: isOn ? null : 0 });
            }}
            className={cn(
              'inline-flex items-center rounded-md border px-2.5 py-1.5 text-xs font-medium transition-colors',
              'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring',
              isOn && color
                ? [color.lineBg, color.border, color.text]
                : 'border-input bg-transparent text-muted-foreground hover:bg-accent hover:text-accent-foreground',
            )}
          >
            {name}
          </button>
        );
      })}
    </div>
  );
}
