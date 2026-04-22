import 'package:flutter/material.dart';

/// A notepad area for an item.
class ItemNotes extends StatefulWidget {
  /// Creates a new [ItemNotes].
  const ItemNotes({
    required this.name,
    super.key,
  });

  /// The item name.
  final String name;

  @override
  State<ItemNotes> createState() => _ItemNotesState();
}

class _ItemNotesState extends State<ItemNotes> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        children: [
          // Category label.
          const ListTile(
            title: Text(
              'Notes:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          // Input field.
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 2),
            child: TextFormField(
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Enter your notes here...',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
