import 'package:eodb/src/db/database.dart';
import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/model/compound_model.dart';
import 'package:eodb/src/widgets/eo_network_image.dart';
import 'package:eodb/src/widgets/item_content_list.dart';
import 'package:flutter/material.dart';

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
  /// Create a [CompoundModel] from the EssentialOils.org JSON entry.
  Future<CompoundModel> _loadModelFromJson() async {
    final json = await Database.instance.loadItemJson(
      widget.name,
      ItemType.compound,
    );
    return CompoundModel.fromJson(json);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadModelFromJson(),
      builder: (context, asyncSnapshot) {
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
              trailing: EoNetworkImage(imageUrlSegment: model.imageUrl),
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
              ItemContentList(
                contentModels: model.oilContent!,
                type: ItemType.oil,
              ),
          ],
        );
      },
    );
  }
}
