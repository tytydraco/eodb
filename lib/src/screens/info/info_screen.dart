import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/screens/info/info_compound.dart';
import 'package:eodb/src/screens/info/info_oil.dart';
import 'package:flutter/material.dart';

/// The details screen for a particular item.
class InfoScreen extends StatefulWidget {
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
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    final infoWidget = (widget.type == ItemType.compound)
        ? InfoCompound(name: widget.name)
        : InfoOil(name: widget.name);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: infoWidget,
    );
  }
}
