import 'package:flutter/material.dart';

/// Texto colapsável com botão "ver mais/menos" e gradiente no rodapé.
class CollapsibleText extends StatefulWidget {
  final String text;
  final int initialMaxLines;
  final TextStyle? style;

  const CollapsibleText(
    this.text, {
    super.key,
    this.initialMaxLines = 6,
    this.style,
  });

  @override
  State<CollapsibleText> createState() => _CollapsibleTextState();
}

class _CollapsibleTextState extends State<CollapsibleText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      widget.text,
      style: widget.style ?? TextStyle(color: Colors.grey[700], fontSize: 14),
      maxLines: _expanded ? null : widget.initialMaxLines,
      overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWidget,
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () => setState(() => _expanded = !_expanded),
            icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            label: Text(_expanded ? 'Ver menos' : 'Ver mais'),
          ),
        ),
      ],
    );
  }
}

/// TextFormField que cresce em altura conforme o conteúdo.
class AutoGrowTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final int minLines;
  final int maxLinesCap;

  const AutoGrowTextFormField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.minLines = 3,
    this.maxLinesCap = 24,
  });

  @override
  State<AutoGrowTextFormField> createState() => _AutoGrowTextFormFieldState();
}

class _AutoGrowTextFormFieldState extends State<AutoGrowTextFormField> {
  int _currentMaxLines = 3;

  @override
  void initState() {
    super.initState();
    _currentMaxLines = widget.minLines;
    widget.controller.addListener(_recomputeLines);
    // Inicializa com o conteúdo existente
    WidgetsBinding.instance.addPostFrameCallback((_) => _recomputeLines());
  }

  @override
  void dispose() {
    widget.controller.removeListener(_recomputeLines);
    super.dispose();
  }

  void _recomputeLines() {
    final text = widget.controller.text;
    final lineBreaks = '\n'.allMatches(text).length + 1;
    final approxWrappedLines = (text.length / 60).ceil();
    final needed = [
      lineBreaks,
      approxWrappedLines,
      widget.minLines,
    ].reduce((a, b) => a > b ? a : b);
    final newMax = needed.clamp(widget.minLines, widget.maxLinesCap);
    if (newMax != _currentMaxLines) {
      setState(() => _currentMaxLines = newMax);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onChanged: widget.onChanged,
      minLines: widget.minLines,
      maxLines: _currentMaxLines,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
    );
  }
}
