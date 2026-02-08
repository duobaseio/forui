import defaultMdxComponents from 'fumadocs-ui/mdx';
import type { MDXComponents } from 'mdx/types';
import { Mermaid } from '@/components/mdx/mermaid';
import { cn } from '@/lib/utils';

export function getMDXComponents(components?: MDXComponents): MDXComponents {
  return {
    ...defaultMdxComponents,
    ...components,
    ul: (props) => <ul {...props} className={cn(props.className, '!ps-8 !mt-2 !mb-6')} />,
    ol: (props) => <ol {...props} className={cn(props.className, '!ps-8 !mt-2 !mb-6')} />,
    li: (props) => <li {...props} className={cn(props.className, '!my-1')} />,
    th: (props) => <th {...props} className={cn(props.className, 'py-1!')} />,
    td: (props) => <td {...props} className={cn(props.className, 'py-0!')} />,
    Mermaid,
  };
}
