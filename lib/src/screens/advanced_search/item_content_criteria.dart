import 'package:eodb/src/db/database.dart';
import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/model/filter_mode.dart';
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
  final _itemCriteriaFilters = <ItemCriteriaFilter>[
    ItemCriteriaFilter(
      name: '123',
      type: ItemType.compound,
      percentage: 123,
      filterMode: FilterMode.equal,
    ),
  ];

  Future<void> _editFilter(int index) async {
    final filter = _itemCriteriaFilters[index];

    final newFilter = await Navigator.push(
      context,
      MaterialPageRoute<ItemCriteriaFilter>(
        builder: (context) => EditFilterCriteria(
          itemCriteriaFilter: filter,
        ),
      ),
    );

    if (newFilter != null) {
      setState(() {
        _itemCriteriaFilters[index] = newFilter;
      });
    }
  }

  Widget _criteriaList() {
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
          title: const Text('Compound filters'),
          trailing: IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                // Create the SelectionScreen in the next step.
                MaterialPageRoute<String>(
                  builder: (context) => Material(
                    child: DatabaseList(
                      names: Database.instance.compoundNamesDb,
                      type: ItemType.compound,
                      returnSelection: true,
                    ),
                  ),
                ),
              );
              if (result == null) return;

              setState(() {
                _itemCriteriaFilters.add(
                  ItemCriteriaFilter(
                    name: result,
                    type: ItemType.compound,
                    percentage: 0,
                    filterMode: FilterMode.equal,
                  ),
                );
              });
            },
            icon: const Icon(Icons.add),
          ),
        ),
        _criteriaList(),
      ],
    );
  }
}
