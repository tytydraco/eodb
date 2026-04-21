import 'package:flutter/material.dart';

/// A search bar widget with decoration.
class ItemSearchBar extends StatelessWidget {
  /// Creates a new [ItemSearchBar].
  const ItemSearchBar({
    required this.controller,
    this.onChanged,
    super.key,
  });

  /// The text editing controller.
  final TextEditingController controller;

  /// Called when the text input changes.
  final Future<void> Function(String criteria)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hint: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Search'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.search),
            ),
          ],
        ),
      ),
    );
  }
}
