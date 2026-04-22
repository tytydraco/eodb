import 'package:eodb/src/db/database.dart';
import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/widgets/database_list.dart';
import 'package:flutter/material.dart';

/// The compounds tab.
class CompoundsTab extends StatelessWidget {
  /// Creates a new [CompoundsTab].
  const CompoundsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DatabaseList(
      names: Database.instance.compoundNamesDb.toList(),
      type: ItemType.compound,
    );
  }
}
