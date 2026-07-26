'use client';

import { usePathname } from 'next/navigation';
import { useEffect, useRef } from 'react';

const src = '//cdn.carbonads.com/carbon.js?serve=CWBDE277&placement=foruidev&format=responsive';
const dev = process.env.NODE_ENV === 'development';

export function Ads({ className }: { className?: string }) {
  const slot = useRef<HTMLDivElement>(null);
  const pathname = usePathname();

  useEffect(() => {
    const current = slot.current;
    if (!current || dev) return;

    const script = document.createElement('script');
    script.async = true;
    script.id = '_carbonads_js';
    script.src = src;
    current.append(script);

    return () => current.replaceChildren();
  }, [pathname]);

  return (
    <div ref={slot} className={className} style={{ minHeight: 155 }}>
      {dev && (
        <div className="grid min-h-[155px] place-items-center rounded-md border text-xs text-muted-foreground">
          Advertisement
        </div>
      )}
    </div>
  );
}
