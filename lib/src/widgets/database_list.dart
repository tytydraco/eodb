import 'package:eodb/src/db/database.dart';
import 'package:eodb/src/db/storage.dart';
import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/screens/info/info_screen.dart';
import 'package:eodb/src/widgets/bookmark_icon_button.dart';
import 'package:eodb/src/widgets/item_search_bar.dart';
import 'package:flutter/material.dart';

/// A vertical scrolling list derived from the [Database].
class DatabaseList extends StatefulWidget {
  /// Creates a new [DatabaseList].
  const DatabaseList({
    required this.names,
    required this.type,
    this.returnSelection = false,
    super.key,
  });

  /// The list of names to display.
  final List<String> names;

  /// The type of the items in this list.
  final ItemType type;

  /// Return the selection as a result.
  final bool returnSelection;

  @override
  State<DatabaseList> createState() => _DatabaseListState();
}

class _DatabaseListState extends State<DatabaseList> {
  final _searchController = TextEditingController();
  String? _criteria;

  /// Show the info screen for an item.
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

    // Update state in case bookmark status changed within info screen.
    if (mounted) setState(() {});
  }

  /// Return a list of names that match the search criteria.
  List<String> _filterNames() {
    // Sort by name, ascending.
    final sortedNamesAscending = widget.names.toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    // Sort by bookmarked items.
    final sortedNamesBookmarked = sortedNamesAscending.toList()
      ..sort((a, b) {
        final aIsBookmarked = Storage.instance.bookmarkedNames.contains(a);
        final bIsBookmarked = Storage.instance.bookmarkedNames.contains(b);

        if (aIsBookmarked && !bIsBookmarked) return -1;
        if (!aIsBookmarked && bIsBookmarked) return 1;
        return 0;
      });

    // No search criteria specified.
    if (_criteria == null) return sortedNamesBookmarked;

    // Only return matching results.
    return sortedNamesBookmarked
        .where(
          (name) => name.toLowerCase().contains(_criteria!.toLowerCase()),
        )
        .toList();
  }

  /// Build a [ListTile] for each item.
  Widget _buildItemListTile(String name) {
    return ListTile(
      title: Text(name),
      trailing: BookmarkIconButton(
        name: name,
        onChanged: () => setState(() {}),
      ),
      onTap: () => widget.returnSelection
          ? Navigator.pop<String>(context, name)
          : _showInfo(name),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredNames = _filterNames();

    return Scaffold(
      appBar: AppBar(
        title: ItemSearchBar(
          controller: _searchController,
          onChanged: (criteria) async => setState(() => _criteria = criteria),
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          final name = filteredNames[index];
          return _buildItemListTile(name);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: filteredNames.length,
      ),
    );
  }
}
