import 'package:eodb/src/db/database.dart';
import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/widgets/database_list.dart';
import 'package:eodb/src/widgets/item_search_bar.dart';
import 'package:flutter/material.dart';

/// The oils tab.
class OilsTab extends StatefulWidget {
  /// Creates a new [OilsTab].
  const OilsTab({super.key});

  @override
  State<OilsTab> createState() => _OilsTabState();
}

class _OilsTabState extends State<OilsTab> {
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
        names: Database.instance.oilNamesDb,
        type: ItemType.oil,
        criteria: _criteria,
      ),
    );
  }
}
