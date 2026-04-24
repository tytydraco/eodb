import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/model/content_model.dart';
import 'package:eodb/src/screens/info/info_screen.dart';
import 'package:eodb/src/widgets/item_content_chart.dart';
import 'package:flutter/material.dart';

/// The list of item content for compounds and oils.
class ContentScreen extends StatefulWidget {
  /// Creates a new [ContentScreen].
  const ContentScreen({
    required this.contentModels,
    required this.type,
    super.key,
  });

  /// The list of [ContentModel]s.
  final List<ContentModel> contentModels;

  /// The item type.
  final ItemType type;

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
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

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type.displayName} content'),
      ),
      body: ListView(
        children: [
          // Category label.
          ListTile(
            title: Text(
              '${widget.type.displayName} content:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          // Chart.
          ItemContentChart(contentModels: sortedContentModels),

          // The item content elements.
          for (final contentModel in sortedContentModels) ...[
            const Divider(),
            ListTile(
              onTap: () async => _showInfo(contentModel.name),
              title: Text(contentModel.name),
              subtitle: Text('${contentModel.percentage}%'),
            ),
          ],
        ],
      ),
    );
  }
}
