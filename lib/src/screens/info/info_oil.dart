import 'package:eodb/src/db/database.dart';
import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/model/oil_model.dart';
import 'package:eodb/src/widgets/eo_network_image.dart';
import 'package:eodb/src/widgets/item_notes.dart';
import 'package:eodb/src/widgets/show_content.dart';
import 'package:flutter/material.dart';

/// The info for an oil.
class InfoOil extends StatefulWidget {
  /// Creates a new [InfoOil].
  const InfoOil({
    required this.name,
    super.key,
  });

  /// The oil name.
  final String name;

  @override
  State<InfoOil> createState() => _InfoOilState();
}

class _InfoOilState extends State<InfoOil> {
  late Future<OilModel> _loadFuture;

  /// Create an [OilModel] from the EssentialOils.org JSON entry.
  Future<OilModel> _loadModelFromJson() async {
    final json = await Database.instance.loadItemJson(
      widget.name,
      ItemType.oil,
    );
    return OilModel.fromJson(json);
  }

  @override
  void initState() {
    super.initState();
    _loadFuture = _loadModelFromJson();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadFuture,
      builder: (context, asyncSnapshot) {
        if (!asyncSnapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final model = asyncSnapshot.data!;
        return ListView(
          padding: const EdgeInsets.only(bottom: 10),
          children: [
            ListTile(
              title: const Text('Image'),
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
              title: const Text('Botanical name'),
              subtitle: Text(model.botanicalName ?? 'N/A'),
            ),
            const Divider(),
            ListTile(
              title: const Text('CAS #'),
              subtitle: Text(model.cas ?? 'N/A'),
            ),
            const Divider(),
            ListTile(
              title: const Text('Publication author'),
              subtitle: Text(model.publicationAuthor ?? 'N/A'),
            ),
            const Divider(),
            ListTile(
              title: const Text('Publication title'),
              subtitle: Text(model.publicationTitle ?? 'N/A'),
            ),
            const Divider(),
            ListTile(
              title: const Text('Publication date'),
              subtitle: Text(model.publicationDate ?? 'N/A'),
            ),
            const Divider(),
            ItemNotes(name: widget.name),
            const Divider(),
            if (model.compoundContent != null &&
                model.compoundContent!.isNotEmpty)
              ShowContent(
                contentModels: model.compoundContent!,
                type: ItemType.compound,
              ),
          ],
        );
      },
    );
  }
}
