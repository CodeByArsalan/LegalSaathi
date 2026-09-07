import 'package:flutter/material.dart';

/// Renders the markdown the assistant answers in.
///
/// Both the models the server relays to and its own fallback engine answer with
/// `**bold**` lead-ins, `#` headings and `*italic*` asides, so showing the text
/// literally reads as a bug. Only those three rules are handled — between them
/// they cover every answer the API produces — rather than taking on a markdown
/// package for so little.
class MarkdownText extends StatelessWidget {
  const MarkdownText({required this.text, this.style, super.key});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) =>
      Text.rich(TextSpan(style: style, children: markdownSpans(text)));
}

final RegExp _heading = RegExp(r'^#{1,6}\s*');
final RegExp _emphasis = RegExp(r'\*\*(.+?)\*\*|\*(.+?)\*');

const TextStyle _bold = TextStyle(fontWeight: FontWeight.w700);
const TextStyle _italic = TextStyle(fontStyle: FontStyle.italic);

/// The spans for [text]. Public so the parsing can be checked without a widget
/// tree. Each span carries only its difference from the parent, which is how
/// `TextSpan` composes — the base style is set once by [MarkdownText].
List<InlineSpan> markdownSpans(String text) {
  final List<InlineSpan> spans = <InlineSpan>[];
  final List<String> lines = text.split('\n');

  for (int index = 0; index < lines.length; index++) {
    if (index > 0) spans.add(const TextSpan(text: '\n'));

    final String line = lines[index];
    final String body = line.replaceFirst(_heading, '');
    // A heading reads bold whether or not it also carries `**…**` of its own.
    final TextStyle plain = body == line ? const TextStyle() : _bold;

    int cursor = 0;
    for (final RegExpMatch match in _emphasis.allMatches(body)) {
      if (match.start > cursor) {
        spans.add(
          TextSpan(text: body.substring(cursor, match.start), style: plain),
        );
      }
      final String? bold = match.group(1);
      spans.add(
        TextSpan(
          text: bold ?? match.group(2) ?? '',
          style: bold != null ? _bold : _italic,
        ),
      );
      cursor = match.end;
    }
    if (cursor < body.length) {
      spans.add(TextSpan(text: body.substring(cursor), style: plain));
    }
  }

  return spans;
}
