import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/screens/info/info_screen.dart';
import 'package:flutter/material.dart';

/// A vertical scrolling list derived from the [DatabaseList].
class DatabaseList extends StatefulWidget {
  /// Creates a new [DatabaseList].
  const DatabaseList({
    required this.names,
    required this.type,
    this.criteria,
    super.key,
  });

  /// The list of names to display.
  final List<String> names;

  /// The type of the items in this list.
  final ItemType type;

  /// Optional search criteria.
  final String? criteria;

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

  List<String> _filterNames() {
    final sortedNames = widget.names.toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    // No search criteria specified.
    if (widget.criteria == null) return sortedNames;

    return sortedNames
        .where(
          (name) => name.toLowerCase().contains(widget.criteria!.toLowerCase()),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredNames = _filterNames();

    return ListView.separated(
      itemBuilder: (context, index) {
        final name = filteredNames[index];
        return ListTile(
          title: Text(name),
          onTap: () => _showInfo(name),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: filteredNames.length,
    );
  }
}
