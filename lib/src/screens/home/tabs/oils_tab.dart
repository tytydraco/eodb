import 'package:eodb/src/db/database.dart';
import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/widgets/database_list.dart';
import 'package:flutter/material.dart';

/// The oils tab.
class OilsTab extends StatelessWidget {
  /// Creates a new [OilsTab].
  const OilsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DatabaseList(
      names: Database.instance.oilNamesDb.toList(),
      type: ItemType.oil,
    );
  }
}
