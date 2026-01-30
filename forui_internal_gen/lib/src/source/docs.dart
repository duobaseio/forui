
final _comment = RegExp('(/// ?)');

/// Summarizes the multi-line documentation comment by extracting the first sentence.
///
/// Returns null if no summary could be found.
String? summarizeDocs(String? documentation) {
  var lines = documentation?.split('\n').map((l) => l.replaceFirst(_comment, '')) ?? <String>[];
  if (lines.isEmpty) {
    return null;
  }

  if (lines.first case final comment when comment.startsWith('{@macro')) {
    // The macro needs to be on a new line for dart doc to properly parse it.
    return '\n /// $comment';
  }

  if (lines.first case final comment when comment.startsWith('{@template')) {
    // Skip if template is malformed. We assume that a template is multi-lined.
    if (lines.length <= 2) {
      return null;
    }

    lines = lines.skip(1).toList();
  }

  final full = lines.join('\n');
  var bracketDepth = 0;
  var parenDepth = 0;
  var backticked = false;

  String summary = '';
  parse:
  for (var i = 0; i < full.length; i++) {
    final char = full[i];

    switch (char) {
      case '[' when !backticked:
        bracketDepth++;
      case ']' when !backticked:
        bracketDepth--;
      case '(' when !backticked:
        parenDepth++;
      case ')' when !backticked:
        parenDepth--;
      case '`':
        backticked = !backticked;
      case '.' when bracketDepth == 0 && parenDepth == 0 && !backticked:
        // Skip common abbreviations (i.e., e.g.)
        // Both dots in "i.e." and "e.g." need to be skipped

        // Check if this is the first dot: "i." or "e." part of "i.e." or "e.g."
        if (i >= 1 && i + 2 < full.length) {
          if ((full[i - 1] == 'i' && full[i + 1] == 'e' && full[i + 2] == '.') ||
              (full[i - 1] == 'e' && full[i + 1] == 'g' && full[i + 2] == '.')) {
            continue;
          }
        }

        // Check if this is the second dot: final '.' in "i.e." or "e.g."
        if (i >= 3) {
          if ((full[i - 3] == 'i' && full[i - 2] == '.' && full[i - 1] == 'e') ||
              (full[i - 3] == 'e' && full[i - 2] == '.' && full[i - 1] == 'g')) {
            continue;
          }
        }

        // Check if followed by whitespace, EOL, or EOS (to avoid matching decimals like 1.5).
        if (i + 1 >= full.length || full[i + 1] == ' ' || full[i + 1] == '\n') {
          summary = full.substring(0, i + 1).trim();
          break parse;
        }
    }
  }

  summary = summary.replaceAll('\n', ' ');
  return summary.isEmpty ? null : summary;
}
