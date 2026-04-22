import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/model/content_model.dart';
import 'package:eodb/src/screens/info/info_screen.dart';
import 'package:eodb/src/util/capitalize_string.dart';
import 'package:flutter/material.dart';

/// A column holding the list of an item's compound or oil content.
class ItemContentList extends StatefulWidget {
  /// Creates a new [ItemContentList].
  const ItemContentList({
    required this.contentModels,
    required this.type,
    super.key,
  });

  /// The list of [ContentModel]s.
  final List<ContentModel> contentModels;

  /// The item type.
  final ItemType type;

  @override
  State<ItemContentList> createState() => _ItemContentListState();
}

class _ItemContentListState extends State<ItemContentList> {
  /// Show the info screen for the selected item.
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

  @override
  Widget build(BuildContext context) {
    final sortedContentModels = widget.contentModels.toList()
      ..sort((a, b) => b.percentage.compareTo(a.percentage));

    return Card(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        children: [
          // Category label.
          ListTile(
            title: Text(
              '${widget.type.displayName.capitalize()} content:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          // List view of item content.
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final contentModel = sortedContentModels[index];
              return ListTile(
                onTap: () async => _showInfo(contentModel.name),
                title: Text(contentModel.name),
                subtitle: Text('${contentModel.percentage}%'),
              );
            },
            separatorBuilder: (_, _) => const Divider(),
            itemCount: sortedContentModels.length,
          ),
        ],
      ),
    );
  }
}
