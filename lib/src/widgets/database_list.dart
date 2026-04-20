import 'package:flutter/material.dart';

/// A vertical scrolling list derived from the [DatabaseList].
class DatabaseList extends StatefulWidget {
  /// Creates a new [DatabaseList].
  const DatabaseList({super.key, required this.names});

  /// The list of names to display.
  final List<String> names;

  @override
  State<DatabaseList> createState() => _DatabaseListState();
}

class _DatabaseListState extends State<DatabaseList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final name = widget.names[index];
        return ListTile(
          title: Text(name),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: widget.names.length,
    );
  }
}
