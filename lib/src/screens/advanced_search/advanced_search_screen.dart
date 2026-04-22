import 'package:eodb/src/db/database.dart';
import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/model/item_criteria_filter.dart';
import 'package:eodb/src/model/search_criteria.dart';
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

  // The item filter criteria.
  final _itemCriteriaFiltersCompounds = <ItemCriteriaFilter>[];
  final _itemCriteriaFiltersOils = <ItemCriteriaFilter>[];

  // Whether we are loading the results or not.
  var _isLoadingResults = false;

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
    final searchCriteria = SearchCriteria(
      id: _idController.text,
      name: _nameController.text,
      botanicalName: _botanicalNameController.text,
      cas: _casController.text,
      publicationAuthor: _publicationAuthorController.text,
      publicationTitle: _publicationTitleController.text,
      publicationDate: _publicationDateController.text,
      type: _itemTypeFilters.first,
      itemContentCriteria: (_itemTypeFilters.first == ItemType.compound)
          ? _itemCriteriaFiltersCompounds
          : _itemCriteriaFiltersOils,
    );

    // Enable loading indicator.
    setState(() => _isLoadingResults = true);

    // Filter items by advanced criteria.
    final filteredNames = await Database.instance.filterItemsByCriteria(
      searchCriteria,
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

    // Disable loading indicator.
    setState(() => _isLoadingResults = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingResults) {
      return const Material(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
          ItemContentCriteria(
            type: _itemTypeFilters.first,
            itemCriteriaFilters: (_itemTypeFilters.first == ItemType.compound)
                ? _itemCriteriaFiltersCompounds
                : _itemCriteriaFiltersOils,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
