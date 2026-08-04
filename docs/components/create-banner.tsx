import { ArrowUpRight, Palette } from 'lucide-react';

export function CreateBanner() {
  return (
    <a
      href="https://create.forui.dev"
      target="_blank"
      rel="noopener noreferrer"
      className="not-prose group my-6 flex items-center gap-4 rounded-xl border bg-card p-4 no-underline shadow-sm
        transition-colors hover:bg-accent"
    >
      <div className="flex size-10 shrink-0 items-center justify-center rounded-lg border bg-background">
        <Palette className="size-5" />
      </div>
      <div className="min-w-0 flex-1">
        <p className="text-sm font-semibold text-foreground">Forui Create</p>
        <p className="text-sm text-muted-foreground">
          Design your theme visually in the browser and preview it live, no setup required.
        </p>
      </div>
      <ArrowUpRight
        className="size-4 shrink-0 text-muted-foreground"
      />
    </a>
  );
}
