export interface CategoryColor {
  lineBg: string;
  border: string;
  text: string;
}

const CATEGORY_COLORS: CategoryColor[] = [
  {
    lineBg: 'bg-blue-500/10 dark:bg-blue-500/15',
    border: 'border-blue-500/25 dark:border-blue-500/30',
    text: 'text-blue-600 dark:text-blue-300',
  },
  {
    lineBg: 'bg-green-500/10 dark:bg-green-500/15',
    border: 'border-green-500/25 dark:border-green-500/30',
    text: 'text-green-700 dark:text-green-300',
  },
  {
    lineBg: 'bg-purple-500/10 dark:bg-purple-500/15',
    border: 'border-purple-500/25 dark:border-purple-500/30',
    text: 'text-purple-700 dark:text-purple-300',
  },
  {
    lineBg: 'bg-amber-500/10 dark:bg-amber-500/15',
    border: 'border-amber-500/25 dark:border-amber-500/30',
    text: 'text-amber-700 dark:text-amber-300',
  },
];

export function getCategoryColor(index: number): CategoryColor {
  return CATEGORY_COLORS[index % CATEGORY_COLORS.length];
}
