import 'package:flutter/material.dart';

/// Constrói um InlineSpan a partir de marcações simples: [b] [/b], [i] [/i], [u] [/u].
/// - Negrito é renderizado em vermelho.
InlineSpan buildFormattedSpan(
  String input, {
  TextStyle? baseStyle,
  Color boldColor = Colors.red,
}) {
  baseStyle ??= const TextStyle(fontSize: 14, color: Colors.black87);

  InlineSpan parse(String text, TextStyle style) {
    final spans = <InlineSpan>[];
    while (text.isNotEmpty) {
      final match = RegExp(r"\[(b|i|u)\]").firstMatch(text);
      if (match == null) {
        spans.add(TextSpan(text: text, style: style));
        break;
      }

      // Texto antes da tag
      if (match.start > 0) {
        spans.add(TextSpan(text: text.substring(0, match.start), style: style));
      }

      final tag = match.group(1)!; // b, i, u
      final endTag = '[/$tag]';
      final afterOpen = text.substring(match.end);
      final endIndex = afterOpen.indexOf(endTag);
      if (endIndex == -1) {
        // Tag sem fechamento: trata como texto puro
        spans.add(TextSpan(text: text.substring(match.start), style: style));
        break;
      }

      final inside = afterOpen.substring(0, endIndex);
      final rest = afterOpen.substring(endIndex + endTag.length);

      TextStyle childStyle = style;
      if (tag == 'b') {
        childStyle = style.copyWith(
          fontWeight: FontWeight.w700,
          color: boldColor,
        );
      } else if (tag == 'i') {
        childStyle = style.copyWith(fontStyle: FontStyle.italic);
      } else if (tag == 'u') {
        childStyle = style.copyWith(decoration: TextDecoration.underline);
      }

      spans.add(parse(inside, childStyle));
      text = rest; // continua após o bloco
    }

    return TextSpan(children: spans, style: style);
  }

  return parse(input, baseStyle);
}

/// Controller que renderiza inline as marcações [b]/[i]/[u] dentro do próprio campo.
class MarkupTextEditingController extends TextEditingController {
  MarkupTextEditingController({super.text});

  @override
  TextSpan buildTextSpan({
    BuildContext? context,
    TextStyle? style,
    bool? withComposing,
  }) {
    final span = buildFormattedSpan(
      text,
      baseStyle: style,
      boldColor: Colors.red,
    );
    // Nota: ignoramos composing para simplificar a renderização de destaque.
    return span as TextSpan;
  }
}

/// RichText com comportamento colapsável, baseado em InlineSpan.
class CollapsibleRichText extends StatefulWidget {
  final String text;
  final int initialMaxLines;
  final TextStyle? style;
  final Color boldColor;

  const CollapsibleRichText(
    this.text, {
    super.key,
    this.initialMaxLines = 6,
    this.style,
    this.boldColor = Colors.red,
  });

  @override
  State<CollapsibleRichText> createState() => _CollapsibleRichTextState();
}

class _CollapsibleRichTextState extends State<CollapsibleRichText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final span = buildFormattedSpan(
      widget.text,
      baseStyle: widget.style,
      boldColor: widget.boldColor,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: span,
          maxLines: _expanded ? null : widget.initialMaxLines,
          overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: () => setState(() => _expanded = !_expanded),
          icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
          label: Text(_expanded ? 'Ver menos' : 'Ver mais'),
        ),
      ],
    );
  }
}

/// Campo de texto com botões para inserir marcações [b], [i], [u].
class FormattedTextEditor extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final bool showPreview;

  const FormattedTextEditor({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.validator,
    this.onChanged,
    this.showPreview = true,
  });

  @override
  State<FormattedTextEditor> createState() => _FormattedTextEditorState();
}

class _FormattedTextEditorState extends State<FormattedTextEditor> {
  late String _previewText;

  void _wrapSelection(TextEditingController c, String open, String close) {
    final sel = c.selection;
    final text = c.text;
    final start = sel.start >= 0 ? sel.start : text.length;
    final end = sel.end >= 0 ? sel.end : text.length;
    final before = text.substring(0, start);
    final selected = text.substring(start, end);
    final after = text.substring(end);

    // 1) Caso seleção já esteja totalmente envolvida: [tag]seleção[/tag] -> remove tags
    if (selected.startsWith(open) && selected.endsWith(close)) {
      final inner = selected.substring(
        open.length,
        selected.length - close.length,
      );
      c.text = '$before$inner$after';
      final newCaretEnd = start + inner.length;
      c.selection = TextSelection(baseOffset: start, extentOffset: newCaretEnd);
      setState(() => _previewText = c.text);
      return;
    }

    // 2) Caso as tags estejam imediatamente ao redor da seleção: ...[tag]|seleção|[/tag]...
    final hasOpenBefore =
        start >= open.length &&
        text.substring(start - open.length, start) == open;
    final hasCloseAfter =
        end + close.length <= text.length &&
        text.substring(end, end + close.length) == close;
    if (hasOpenBefore && hasCloseAfter) {
      final beforeWithout = text.substring(0, start - open.length);
      final afterWithout = text.substring(end + close.length);
      c.text = '$beforeWithout$selected$afterWithout';
      final newStart = start - open.length;
      final newEnd = newStart + selected.length;
      c.selection = TextSelection(baseOffset: newStart, extentOffset: newEnd);
      setState(() => _previewText = c.text);
      return;
    }

    // 3) Caso comum: aplica as tags
    final newText = '$before$open$selected$close$after';
    c.text = newText;
    final newStart = start + open.length;
    final newEnd = newStart + selected.length;
    c.selection = TextSelection(baseOffset: newStart, extentOffset: newEnd);
    setState(() => _previewText = c.text);
  }

  @override
  Widget build(BuildContext context) {
    _previewText = widget.controller.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconButton(
              tooltip: 'Negrito (vermelho)',
              icon: const Icon(Icons.format_bold),
              color: Colors.red,
              onPressed: () => _wrapSelection(widget.controller, '[b]', '[/b]'),
            ),
            IconButton(
              tooltip: 'Itálico',
              icon: const Icon(Icons.format_italic),
              onPressed: () => _wrapSelection(widget.controller, '[i]', '[/i]'),
            ),
            IconButton(
              tooltip: 'Sublinhado',
              icon: const Icon(Icons.format_underline),
              onPressed: () => _wrapSelection(widget.controller, '[u]', '[/u]'),
            ),
          ],
        ),
        TextFormField(
          controller: widget.controller,
          minLines: 3,
          maxLines: 24,
          onChanged: (v) {
            setState(() => _previewText = v);
            widget.onChanged?.call(v);
          },
          validator: widget.validator,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
        if (widget.showPreview) ...[
          const SizedBox(height: 8),
          Text(
            'Pré-visualização',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(12),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey.withAlpha(60)),
            ),
            child: RichText(
              text: buildFormattedSpan(
                _previewText,
                baseStyle: const TextStyle(fontSize: 14, color: Colors.black87),
                boldColor: Colors.red,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
