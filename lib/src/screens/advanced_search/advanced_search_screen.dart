import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/screens/advanced_search/item_content_criteria.dart';
import 'package:eodb/src/widgets/input_tile.dart';
import 'package:flutter/material.dart';

/// The advanced search screen.
class AdvancedSearchScreen extends StatefulWidget {
  /// Creates a new [AdvancedSearchScreen].
  const AdvancedSearchScreen({super.key});

  @override
  State<AdvancedSearchScreen> createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends State<AdvancedSearchScreen> {
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _botanicalNameController = TextEditingController();
  final _casController = TextEditingController();
  final _publicationAuthorController = TextEditingController();
  final _publicationTitleController = TextEditingController();
  final _publicationDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Search'),
      ),
      body: ListView(
        children: [
          InputTile(
            controller: _idController,
            title: 'ID',
            hint: 'Any',
            digitsOnly: true,
          ),
          const Divider(),
          InputTile(
            controller: _nameController,
            title: 'Name',
            hint: 'Any',
          ),
          const Divider(),
          InputTile(
            controller: _botanicalNameController,
            title: 'Botanical name',
            hint: 'Any',
          ),
          const Divider(),
          InputTile(
            controller: _casController,
            title: 'CAS #',
            hint: 'Any',
          ),
          const Divider(),
          InputTile(
            controller: _publicationAuthorController,
            title: 'Publication author',
            hint: 'Any',
          ),
          const Divider(),
          InputTile(
            controller: _publicationTitleController,
            title: 'Publication title',
            hint: 'Any',
          ),
          const Divider(),
          InputTile(
            controller: _publicationDateController,
            title: 'Publication date',
            hint: 'Any',
          ),
          const Divider(),

          const ItemContentCriteria(type: ItemType.compound),
          const Divider(),

          const ItemContentCriteria(type: ItemType.oil),
          const Divider(),
        ],
      ),
    );
  }
}
