import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as fq;
import 'dart:convert';

/// Exibe um diálogo de confirmação para exclusão
Future<bool> showDeleteConfirmationDialog(
  BuildContext context, {
  required String title,
  required String itemName,
  String? customMessage,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder:
        (_) => AlertDialog(
          title: Text(title),
          content: Text(customMessage ?? 'Deseja excluir "$itemName"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Excluir', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
  );
  return confirmed == true;
}

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

/// Constrói um InlineSpan a partir de um Delta JSON (lista de ops do Quill).
/// Suporta apenas os atributos: bold, italic, underline. Qualquer outro é ignorado.
InlineSpan buildDeltaFormattedSpan(
  List<dynamic> ops, {
  TextStyle? baseStyle,
  Color boldColor = Colors.red,
}) {
  baseStyle ??= const TextStyle(fontSize: 14, color: Colors.black87);
  final children = <InlineSpan>[];

  for (final rawOp in ops) {
    if (rawOp is! Map) continue;
    final Object? insertObj = rawOp['insert'];
    if (insertObj == null) continue;
    final String insertText = insertObj.toString();
    TextStyle effective = baseStyle;

    final attrs = rawOp['attributes'];
    if (attrs is Map) {
      final bool isBold = attrs['bold'] == true;
      final bool isItalic = attrs['italic'] == true;
      final bool isUnderline = attrs['underline'] == true;

      if (isBold) {
        effective = effective.copyWith(
          fontWeight: FontWeight.w700,
          color: boldColor,
        );
      }
      if (isItalic) {
        effective = effective.copyWith(fontStyle: FontStyle.italic);
      }
      if (isUnderline) {
        effective = effective.copyWith(decoration: TextDecoration.underline);
      }
    }

    if (insertText.isEmpty) continue;
    children.add(TextSpan(text: insertText, style: effective));
  }

  return TextSpan(children: children, style: baseStyle);
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
    InlineSpan span;
    final raw = widget.text.trim();
    // Detecta Delta JSON (lista de ops) e renderiza como RichText; caso contrário, usa marcações [b]/[i]/[u]
    if (raw.startsWith('[') || raw.startsWith('{')) {
      try {
        final decoded = jsonDecode(raw);
        final List<dynamic> ops;
        if (decoded is List) {
          ops = decoded;
        } else if (decoded is Map && decoded['ops'] is List) {
          ops = decoded['ops'] as List;
        } else {
          ops = const [];
        }
        span = buildDeltaFormattedSpan(
          ops,
          baseStyle: widget.style,
          boldColor: widget.boldColor,
        );
      } catch (_) {
        span = buildFormattedSpan(
          widget.text,
          baseStyle: widget.style,
          boldColor: widget.boldColor,
        );
      }
    } else {
      span = buildFormattedSpan(
        widget.text,
        baseStyle: widget.style,
        boldColor: widget.boldColor,
      );
    }

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
        // Para texto externo, remove toda formatação e usa apenas texto puro
        final cleanText = _extractPlainText(_plainTextCache);
        doc = fq.Document()..insert(0, cleanText);
        _plainTextCache = cleanText;
      }
    } catch (_) {
      // Em caso de erro, extrai apenas texto puro
      final cleanText = _extractPlainText(_plainTextCache);
      doc = fq.Document()..insert(0, cleanText);
      _plainTextCache = cleanText;
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
          // Para texto externo, remove toda formatação e usa apenas texto puro
          final plainText = _extractPlainText(raw);
          final len = _quillController.document.length;
          _quillController.replaceText(
            0,
            len,
            plainText,
            const TextSelection.collapsed(offset: 0),
          );
        }
      } catch (_) {
        // Em caso de erro, extrai apenas texto puro
        final plainText = _extractPlainText(_plainTextCache);
        final len = _quillController.document.length;
        _quillController.replaceText(
          0,
          len,
          plainText,
          const TextSelection.collapsed(offset: 0),
        );
      }
    }
  }

  /// Extrai apenas texto puro, removendo formatações HTML, URLs, marcações e outros elementos externos
  String _extractPlainText(String input) {
    String text = input;

    // Remove URLs (SourceURL, http://, https://)
    text = text.replaceAll(RegExp(r'SourceURL:.*?(?=\n|$)'), '');
    text = text.replaceAll(RegExp(r'https?://[^\s]+'), '');

    // Remove marcações HTML básicas
    text = text.replaceAll(RegExp(r'<[^>]*>'), '');

    // Remove marcações de formatação do próprio app [b], [i], [u]
    text = text.replaceAll(RegExp(r'\[/?[biu]\]'), '');

    // Remove quebras de linha excessivas (mais de 2 consecutivas)
    text = text.replaceAll(RegExp(r'\n{3,}'), '\n\n');

    // Remove espaços em branco no início e fim
    text = text.trim();

    return text;
  }

  void _onQuillChanged() {
    // Sanitize delta: allow only bold, italic, underline; drop others
    final ops = List<Map<String, dynamic>>.from(
      _quillController.document.toDelta().toJson().cast<Map<String, dynamic>>(),
    );
    final allowed = {'bold', 'italic', 'underline'};

    for (final op in ops) {
      final attrs = op['attributes'];
      if (attrs is Map) {
        final newAttrs = <String, dynamic>{};
        for (final key in attrs.keys) {
          if (allowed.contains(key)) newAttrs[key] = attrs[key];
        }
        if (newAttrs.isEmpty) {
          op.remove('attributes');
        } else {
          op['attributes'] = newAttrs;
        }
      }
    }

    final deltaJson = jsonEncode(ops);
    if (deltaJson == widget.controller.text) return;

    _plainTextCache = _quillController.document.toPlainText();
    widget.controller.text = deltaJson;
    widget.onChanged?.call(deltaJson);
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
        void toggleAttr(fq.Attribute attribute) {
          final attrs = _quillController.getSelectionStyle().attributes;
          if (attrs.containsKey(attribute.key)) {
            final unset = fq.Attribute.fromKeyValue(attribute.key, null);
            _quillController.formatSelection(unset);
          } else {
            _quillController.formatSelection(attribute);
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Barra fixa de formatação (custom)
            Row(
              children: [
                IconButton(
                  tooltip: 'Negrito',
                  icon: const Icon(Icons.format_bold),
                  onPressed: () => toggleAttr(fq.Attribute.bold),
                ),
                IconButton(
                  tooltip: 'Itálico',
                  icon: const Icon(Icons.format_italic),
                  onPressed: () => toggleAttr(fq.Attribute.italic),
                ),
                IconButton(
                  tooltip: 'Sublinhado',
                  icon: const Icon(Icons.format_underline),
                  onPressed: () => toggleAttr(fq.Attribute.underline),
                ),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: 'Remover formatação',
                  icon: const Icon(Icons.format_clear),
                  onPressed: () {
                    // Limpa os atributos suportados na seleção atual
                    final unsetBold = fq.Attribute.fromKeyValue(
                      fq.Attribute.bold.key,
                      null,
                    );
                    final unsetItalic = fq.Attribute.fromKeyValue(
                      fq.Attribute.italic.key,
                      null,
                    );
                    final unsetUnderline = fq.Attribute.fromKeyValue(
                      fq.Attribute.underline.key,
                      null,
                    );
                    _quillController.formatSelection(unsetBold);
                    _quillController.formatSelection(unsetItalic);
                    _quillController.formatSelection(unsetUnderline);
                  },
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
