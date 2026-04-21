import 'package:eodb/src/db/database.dart';
import 'package:eodb/src/enum/filter_mode.dart';
import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/model/item_criteria_filter.dart';
import 'package:eodb/src/screens/advanced_search/edit_filter_criteria.dart';
import 'package:eodb/src/widgets/database_list.dart';
import 'package:flutter/material.dart';

/// Widget to filter by compound or oil content.
class ItemContentCriteria extends StatefulWidget {
  /// Creates a new [ItemContentCriteria].
  const ItemContentCriteria({
    required this.type,
    super.key,
  });

  /// The type of the item to filter.
  final ItemType type;

  @override
  State<ItemContentCriteria> createState() => _ItemContentCriteriaState();
}

class _ItemContentCriteriaState extends State<ItemContentCriteria> {
  late final List<String> db = (widget.type == ItemType.compound)
      ? Database.instance.compoundNamesDb
      : Database.instance.oilNamesDb;

  final _itemCriteriaFilters = <ItemCriteriaFilter>[];

  /// Edit an existing filter from the list.
  Future<void> _editFilter(int index) async {
    final filter = _itemCriteriaFilters[index];

    // Request result from edit screen.
    final newFilter = await Navigator.push(
      context,
      MaterialPageRoute<ItemCriteriaFilter>(
        builder: (context) => EditFilterCriteria(
          itemCriteriaFilter: filter,
        ),
      ),
    );

    // Do not apply edits if user selected "Back".
    if (newFilter != null) {
      setState(() {
        _itemCriteriaFilters[index] = newFilter;
      });
    }
  }

  Future<void> _addItem() async {
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute<String>(
        builder: (context) => Material(
          child: DatabaseList(
            names: db,
            type: widget.type,
            returnSelection: true,
          ),
        ),
      ),
    );
    if (result == null) return;

    final filter = ItemCriteriaFilter(
      name: result,
      type: widget.type,
      percentage: 0,
      filterMode: FilterMode.equal,
    );

    setState(() {
      _itemCriteriaFilters.add(filter);
    });

    // Immediately edit the newly added filter.
    final index = _itemCriteriaFilters.indexOf(filter);
    await _editFilter(index);
  }

  /// List view widget for our filters.
  Widget _filterList() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final itemCriteriaFilter = _itemCriteriaFilters[index];
        return ListTile(
          title: Text(itemCriteriaFilter.name),
          subtitle: Text(
            '${itemCriteriaFilter.filterMode.displayName} '
            '${itemCriteriaFilter.percentage}%',
          ),
          leading: IconButton(
            onPressed: () =>
                setState(() => _itemCriteriaFilters.removeAt(index)),
            icon: const Icon(Icons.remove),
          ),
          trailing: IconButton(
            onPressed: () => _editFilter(index),
            icon: const Icon(Icons.edit),
          ),
        );
      },
      itemCount: _itemCriteriaFilters.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('${widget.type.displayName} filters'),
          trailing: IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ),
        _filterList(),
      ],
    );
  }
}
