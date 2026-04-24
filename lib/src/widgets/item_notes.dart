import 'dart:async';

import 'package:eodb/src/db/storage.dart';
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
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // On initialization, fill the text editing controller with the notes.
    unawaited(
      Storage.instance.getNotes(widget.name).then((content) {
        if (content == null || content.isEmpty) return;
        if (!mounted) return;

        setState(() {
          _notesController.text = content;
        });
      }),
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10),
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
              controller: _notesController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Enter your notes here...',
                border: InputBorder.none,
              ),
              onChanged: (content) async {
                await Storage.instance.setNotes(widget.name, content);
              },
            ),
          ),
        ],
      ),
    );
  }
}
