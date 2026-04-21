import 'package:eodb/src/db/database.dart';
import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/screens/advanced_search/item_content_criteria.dart';
import 'package:eodb/src/widgets/database_list.dart';
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

  // Default to compounds because empty selection is disabled.
  var _itemTypeFilters = <ItemType>{ItemType.compound};

  Widget _itemTypeSegmentedButton() {
    return ListTile(
      title: const Text('Item type'),
      trailing: SizedBox(
        width: 200,
        child: SegmentedButton<ItemType>(
          onSelectionChanged: (itemTypeFilters) => setState(() {
            _itemTypeFilters = itemTypeFilters;
          }),
          segments: ItemType.values
              .map(
                (type) => ButtonSegment(
                  value: type,
                  label: Text(type.displayName),
                ),
              )
              .toList(),
          selected: _itemTypeFilters,
          showSelectedIcon: false,
        ),
      ),
    );
  }

  Future<void> _showResults() async {
    // Filter items by advanced criteria.
    final filteredNames = await Database.instance.filterItemsByCriteria(
      // TODO(tytydraco): Create advanced criteria model and pass to database
    );

    // Ensure we have not lost context.
    if (!mounted) return;

    // Show the filtered item names.
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => DatabaseList(
          names: filteredNames,
          type: _itemTypeFilters.first,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Search'),
        actions: [
          IconButton(
            onPressed: _showResults,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: ListView(
        children: [
          // ID.
          InputTile(
            controller: _idController,
            title: 'ID',
            hint: 'Any',
            digitsOnly: true,
          ),
          const Divider(),

          // Name.
          InputTile(
            controller: _nameController,
            title: 'Name',
            hint: 'Any',
          ),
          const Divider(),

          // Botanical name.
          InputTile(
            controller: _botanicalNameController,
            title: 'Botanical name',
            hint: 'Any',
          ),
          const Divider(),

          // CAS #.
          InputTile(
            controller: _casController,
            title: 'CAS #',
            hint: 'Any',
          ),
          const Divider(),

          // Publication author.
          InputTile(
            controller: _publicationAuthorController,
            title: 'Publication author',
            hint: 'Any',
          ),
          const Divider(),

          // Publication title.
          InputTile(
            controller: _publicationTitleController,
            title: 'Publication title',
            hint: 'Any',
          ),
          const Divider(),

          // Publication date.
          InputTile(
            controller: _publicationDateController,
            title: 'Publication date',
            hint: 'Any',
          ),
          const Divider(),

          // Item type.
          _itemTypeSegmentedButton(),
          const Divider(),

          // Compound criteria.
          const ItemContentCriteria(type: ItemType.compound),
          const Divider(),

          // Oil criteria.
          const ItemContentCriteria(type: ItemType.oil),
          const Divider(),
        ],
      ),
    );
  }
}
