import type { ThemedTokenWithVariants } from 'shiki';
import type { Annotation, ProcessedLine, TokenGroup, SnippetData } from './types';

export function collectAnnotations(snippet: SnippetData): Annotation[] {
  const annotations: Annotation[] = [];

  for (const link of snippet.links) {
    annotations.push({
      offset: link.offset,
      length: link.length,
      type: 'link',
      url: link.url,
    });
  }

  for (const tooltip of snippet.tooltips) {
    annotations.push({
      offset: tooltip.offset,
      length: tooltip.length,
      type: 'tooltip',
      snippet: tooltip.snippet,
    });
  }

  return annotations;
}

export function processTokens(
  lines: ThemedTokenWithVariants[][],
  annotations: Annotation[],
  highlights: { start: number; end: number }[],
): ProcessedLine[] {
  const boundaries = new Set<number>();
  for (const annotation of annotations) {
    boundaries.add(annotation.offset);
    boundaries.add(annotation.offset + annotation.length);
  }

  return lines.map((lineTokens, lineIdx) => ({
    tokenGroups: splitIntoGroups(lineTokens, annotations, boundaries),
    highlighted: highlights.some((h) => lineIdx >= h.start && lineIdx <= h.end),
  }));
}

function splitIntoGroups(
  lineTokens: ThemedTokenWithVariants[],
  annotations: Annotation[],
  boundaries: Set<number>,
): TokenGroup[] {
  const groups: TokenGroup[] = [];
  let currentGroup: TokenGroup | null = null;

  for (const token of lineTokens) {
    const tokenStart = token.offset;
    const tokenEnd = token.offset + token.content.length;

    const splitPoints = [...boundaries]
      .filter((b) => b > tokenStart && b < tokenEnd)
      .sort((a, b) => a - b);

    const allPoints = [tokenStart, ...splitPoints, tokenEnd];

    for (let i = 0; i < allPoints.length - 1; i++) {
      let start = allPoints[i];
      let content = token.content.slice(start - tokenStart, allPoints[i + 1] - tokenStart);

      if (!content) continue;

      const segmentAnnotations = findAnnotationsForOffset(start, allPoints[i + 1], annotations);

      // Strip leading whitespace from annotated segments so indentation isn't linked/underlined.
      if (segmentAnnotations.length > 0) {
        const startWithWhitespace = content.match(/^\s+/);

        if (startWithWhitespace) {
          if (!currentGroup || currentGroup.annotations.length !== 0) {
            currentGroup = { tokens: [], annotations: [] };
            groups.push(currentGroup);
          }
          currentGroup.tokens.push({ content: startWithWhitespace[0], offset: start, variants: token.variants });

          start += startWithWhitespace[0].length;
          content = content.slice(startWithWhitespace[0].length);
          if (!content) continue;
        }
      }

      // Start new group if annotations changed
      if (!currentGroup || !annotationsMatch(currentGroup.annotations, segmentAnnotations)) {
        currentGroup = { tokens: [], annotations: segmentAnnotations };
        groups.push(currentGroup);
      }

      currentGroup.tokens.push({
        content,
        offset: start,
        variants: token.variants,
      });
    }
  }

  return groups;
}

function findAnnotationsForOffset(start: number, end: number, annotations: Annotation[]): Annotation[] {
  return annotations.filter((annotation) => {
    const annotationEnd = annotation.offset + annotation.length;
    return start < annotationEnd && annotation.offset < end;
  });
}

function annotationsMatch(a: Annotation[], b: Annotation[]): boolean {
  if (a.length !== b.length) return false;
  return a.every(
    (annotation, i) =>
      annotation.offset === b[i].offset && annotation.length === b[i].length && annotation.type === b[i].type,
  );
}
