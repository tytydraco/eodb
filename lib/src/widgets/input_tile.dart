import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A list tile with an input field.
class InputTile extends StatelessWidget {
  /// Creates a new [InputTile].
  const InputTile({
    required this.controller,
    required this.title,
    this.hint,
    this.subtitle,
    this.digitsOnly = false,
    this.decimalAllowed = false,
    super.key,
  });

  /// The text controller.
  final TextEditingController controller;

  /// The title.
  final String title;

  /// The subtitle.
  final String? subtitle;

  /// The input field hint.
  final String? hint;

  /// Whether or not we should restrict to digits.
  final bool digitsOnly;

  /// Whether or not we should allow decimals.
  final bool decimalAllowed;

  List<TextInputFormatter> _getInputFormatters() {
    if (digitsOnly && decimalAllowed) {
      return [FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d*)?'))];
    }
    if (digitsOnly) return [FilteringTextInputFormatter.digitsOnly];
    return [];
  }

  TextInputType? _getTextInputType() {
    if (digitsOnly) {
      return TextInputType.numberWithOptions(decimal: decimalAllowed);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: SizedBox(
        width: 200,
        child: TextFormField(
          inputFormatters: _getInputFormatters(),
          keyboardType: _getTextInputType(),
          controller: controller,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
