import 'package:eodb/src/db/database.dart';
import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/widgets/database_list.dart';
import 'package:eodb/src/widgets/item_search_bar.dart';
import 'package:flutter/material.dart';

/// The compounds tab.
class CompoundsTab extends StatefulWidget {
  /// Creates a new [CompoundsTab].
  const CompoundsTab({super.key});

  @override
  State<CompoundsTab> createState() => _CompoundsTabState();
}

class _CompoundsTabState extends State<CompoundsTab> {
  final _searchController = TextEditingController();
  String? _criteria;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ItemSearchBar(
          controller: _searchController,
          onChanged: (criteria) async => setState(() => _criteria = criteria),
        ),
      ),
      body: DatabaseList(
        names: Database.instance.compoundNamesDb,
        type: ItemType.compound,
        criteria: _criteria,
      ),
    );
  }
}
