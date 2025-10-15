import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as fq;
import 'dart:convert';

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

  const FormattedTextEditor({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.validator,
    this.onChanged,
  });

  @override
  State<FormattedTextEditor> createState() => _FormattedTextEditorState();
}

class _FormattedTextEditorState extends State<FormattedTextEditor> {
  late fq.QuillController _quillController;
  String _plainTextCache = '';

  @override
  void initState() {
    super.initState();
    _plainTextCache = widget.controller.text;
    // Se já houver Delta JSON no controller, carrega; senão usa texto puro
    fq.Document doc;
    try {
      final raw = widget.controller.text.trim();
      if (raw.startsWith('[') || raw.startsWith('{')) {
        final dynamic decoded = jsonDecode(raw);
        doc = fq.Document.fromJson(decoded as List);
      } else {
        doc = fq.Document()..insert(0, _plainTextCache);
      }
    } catch (_) {
      doc = fq.Document()..insert(0, _plainTextCache);
    }
    _quillController = fq.QuillController(
      document: doc,
      selection: const TextSelection.collapsed(offset: 0),
    );
    _quillController.addListener(_onQuillChanged);
  }

  @override
  void didUpdateWidget(covariant FormattedTextEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller.text != widget.controller.text &&
        widget.controller.text != _plainTextCache) {
      // Atualiza o documento ao receber texto externo
      _plainTextCache = widget.controller.text;
      try {
        final raw = widget.controller.text.trim();
        if (raw.startsWith('[') || raw.startsWith('{')) {
          final dynamic decoded = jsonDecode(raw);
          _quillController.document = fq.Document.fromJson(decoded as List);
        } else {
          final len = _quillController.document.length;
          _quillController.replaceText(
            0,
            len,
            _plainTextCache,
            const TextSelection.collapsed(offset: 0),
          );
        }
      } catch (_) {
        final len = _quillController.document.length;
        _quillController.replaceText(
          0,
          len,
          _plainTextCache,
          const TextSelection.collapsed(offset: 0),
        );
      }
    }
  }

  void _onQuillChanged() {
    final plain = _quillController.document.toPlainText();
    final deltaJson = jsonEncode(_quillController.document.toDelta().toJson());
    if (deltaJson == widget.controller.text) return;
    _plainTextCache = plain;
    // Salva como Delta JSON no controller para persistir formatação
    widget.controller.text = deltaJson;
    widget.onChanged?.call(deltaJson);
    setState(() {});
  }

  @override
  void dispose() {
    _quillController.removeListener(_onQuillChanged);
    _quillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: _plainTextCache,
      validator: widget.validator,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Barra fixa de formatação (custom)
            Row(
              children: [
                IconButton(
                  tooltip: 'Negrito',
                  icon: const Icon(Icons.format_bold),
                  onPressed:
                      () => _quillController.formatSelection(fq.Attribute.bold),
                ),
                IconButton(
                  tooltip: 'Itálico',
                  icon: const Icon(Icons.format_italic),
                  onPressed:
                      () =>
                          _quillController.formatSelection(fq.Attribute.italic),
                ),
                IconButton(
                  tooltip: 'Sublinhado',
                  icon: const Icon(Icons.format_underline),
                  onPressed:
                      () => _quillController.formatSelection(
                        fq.Attribute.underline,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Editor rolável mantendo a barra no topo
            Container(
              constraints: const BoxConstraints(minHeight: 160, maxHeight: 320),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: fq.QuillEditor.basic(controller: _quillController),
              ),
            ),
            if (state.hasError) ...[
              const SizedBox(height: 6),
              Text(
                state.errorText ?? '',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ],
        );
      },
    );
  }
}
