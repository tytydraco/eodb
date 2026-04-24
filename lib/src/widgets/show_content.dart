import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/model/content_model.dart';
import 'package:eodb/src/screens/content/content_screen.dart';
import 'package:flutter/material.dart';

/// Show content list tile to navigate to the [ContentScreen].
class ShowContent extends StatefulWidget {
  /// Creates a new [ShowContent].
  const ShowContent({
    required this.contentModels,
    required this.type,
    super.key,
  });

  /// The list of [ContentModel]s.
  final List<ContentModel> contentModels;

  /// The item type.
  final ItemType type;

  @override
  State<ShowContent> createState() => _ShowContentState();
}

class _ShowContentState extends State<ShowContent> {
  Future<void> _showContent() async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ContentScreen(
          contentModels: widget.contentModels,
          type: widget.type,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Show ${widget.type.displayName.toLowerCase()} content'),
      onTap: _showContent,
    );
  }
}
