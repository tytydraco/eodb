import 'package:eodb/src/enum/item_type.dart';
import 'package:flutter/material.dart';

/// A search bar widget with decoration.
class ItemSearchBar extends StatelessWidget {
  /// Creates a new [ItemSearchBar].
  const ItemSearchBar({
    required this.controller,
    required this.type,
    this.onChanged,
    super.key,
  });

  /// The text editing controller.
  final TextEditingController controller;

  /// The item type.
  final ItemType type;

  /// Called when the text input changes.
  final Future<void> Function(String criteria)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: InputBorder.none,
        hint: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${type.displayName}s'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.search),
            ),
          ],
        ),
      ),
    );
  }
}
