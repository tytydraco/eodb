import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/model/content_model.dart';
import 'package:eodb/src/screens/info/info_screen.dart';
import 'package:flutter/material.dart';

/// Given a list of [contentModels], yield sorted [ListTile]s with [Divider]s.
Iterable<Widget> generateItemContentList(
  BuildContext context,
  List<ContentModel> contentModels,
  ItemType type,
) sync* {
  /// Show the info screen for the selected item.
  Future<void> showInfo(String name) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => InfoScreen(
          name: name,
          type: type,
        ),
      ),
    );
  }

  final sortedContentModels = contentModels.toList()
    ..sort((a, b) => b.percentage.compareTo(a.percentage));
  for (final contentModel in sortedContentModels) {
    yield ListTile(
      onTap: () async => showInfo(contentModel.name),
      title: Text(contentModel.name),
      subtitle: Text('${contentModel.percentage}%'),
    );
    yield const Divider();
  }
}
