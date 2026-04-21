import 'dart:convert';

import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/model/compound_model.dart';
import 'package:eodb/src/screens/info/info_screen.dart';
import 'package:eodb/src/util/slugify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The info for a compound.
class InfoCompound extends StatefulWidget {
  /// Creates a new [InfoCompound].
  const InfoCompound({
    required this.name,
    super.key,
  });

  /// The compound name.
  final String name;

  @override
  State<InfoCompound> createState() => _InfoCompoundState();
}

class _InfoCompoundState extends State<InfoCompound> {
  Future<CompoundModel> _loadModelFromJson() async {
    final slug = slugify(widget.name);
    final rawJson = await rootBundle.loadString(
      'assets/eoscraper/compounds/$slug.json',
    );
    final json = jsonDecode(rawJson) as Map<String, dynamic>;
    return CompoundModel.fromJson(json);
  }

  Iterable<Widget> _generateContentList(CompoundModel model) sync* {
    final sortedModels = model.oilContent!.toList()
      ..sort(
        (a, b) => b.percentage.compareTo(a.percentage),
      );

    for (final compoundModel in sortedModels) {
      yield ListTile(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => InfoScreen(
                name: compoundModel.name,
                type: ItemType.oil,
              ),
            ),
          );
        },
        title: Text(compoundModel.name),
        subtitle: Text('${compoundModel.percentage}%'),
      );
      yield const Divider();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadModelFromJson(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasError) {
          print(asyncSnapshot.error);
        }
        if (!asyncSnapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final model = asyncSnapshot.data!;
        return ListView(
          children: [
            ListTile(
              title: const Text('Molecule'),
              trailing: model.imageUrl != null
                  ? Image.network(
                      alignment: Alignment.centerRight,
                      'https://essentialoils.org/${model.imageUrl!}',
                      errorBuilder: (_, _, _) => const SizedBox.shrink(),
                      loadingBuilder: (_, child, loadingProgress) {
                        // Done loading.
                        if (loadingProgress == null) return child;

                        // Ambiguous file size.
                        if (loadingProgress.expectedTotalBytes == null) {
                          return const CircularProgressIndicator();
                        }

                        // Show real-time progress.
                        final progressPercent =
                            loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!;
                        return CircularProgressIndicator(
                          value: progressPercent,
                        );
                      },
                    )
                  : const Text('N/A'),
            ),
            const Divider(),
            ListTile(
              title: const Text('ID'),
              subtitle: Text(model.id?.toString() ?? 'N/A'),
            ),
            const Divider(),
            ListTile(
              title: const Text('Name'),
              subtitle: Text(model.name),
            ),
            const Divider(),
            ListTile(
              title: const Text('CAS #'),
              subtitle: Text(model.cas ?? 'N/A'),
            ),
            const Divider(),
            if (model.oilContent != null && model.oilContent!.isNotEmpty)
              ..._generateContentList(model),
          ],
        );
      },
    );
  }
}
