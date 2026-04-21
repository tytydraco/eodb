import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/screens/info/info_screen.dart';
import 'package:flutter/material.dart';

/// A vertical scrolling list derived from the [DatabaseList].
class DatabaseList extends StatefulWidget {
  /// Creates a new [DatabaseList].
  const DatabaseList({
    required this.names,
    required this.type,
    super.key,
  });

  /// The list of names to display.
  final List<String> names;

  /// The type of the items in this list.
  final ItemType type;

  @override
  State<DatabaseList> createState() => _DatabaseListState();
}

class _DatabaseListState extends State<DatabaseList> {
  Future<void> _showInfo(String name) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => InfoScreen(
          name: name,
          type: widget.type,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final name = widget.names[index];
        return ListTile(
          title: Text(name),
          onTap: () => _showInfo(name),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: widget.names.length,
    );
  }
}
