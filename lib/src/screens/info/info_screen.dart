import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/screens/info/info_compound.dart';
import 'package:eodb/src/screens/info/info_oil.dart';
import 'package:flutter/material.dart';

/// The details screen for a particular item.
class InfoScreen extends StatelessWidget {
  /// Creates a new [InfoScreen].
  const InfoScreen({
    required this.name,
    required this.type,
    super.key,
  });

  /// The item name.
  final String name;

  /// The item type.
  final ItemType type;

  @override
  Widget build(BuildContext context) {
    // Choose the correct info screen based on the item type.
    final infoWidget = (type == ItemType.compound)
        ? InfoCompound(name: name)
        : InfoOil(name: name);

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: infoWidget,
    );
  }
}
