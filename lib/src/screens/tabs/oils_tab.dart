import 'package:eodb/src/db/database.dart';
import 'package:eodb/src/widgets/database_list.dart';
import 'package:flutter/material.dart';

/// The oils tab.
class OilsTab extends StatefulWidget {
  /// Creates a new [OilsTab].
  const OilsTab({super.key});

  @override
  State<OilsTab> createState() => _OilsTabState();
}

class _OilsTabState extends State<OilsTab> {
  @override
  Widget build(BuildContext context) {
    return DatabaseList(names: Database.instance.oilNamesDb);
  }
}
