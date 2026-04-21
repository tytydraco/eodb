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

  @override
  Widget build(BuildContext context) {
    final inputFormatters = digitsOnly
        ? [FilteringTextInputFormatter.digitsOnly]
        : null;
    final keyboardType = digitsOnly ? TextInputType.number : null;

    return ListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: SizedBox(
        width: 200,
        child: TextFormField(
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
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
