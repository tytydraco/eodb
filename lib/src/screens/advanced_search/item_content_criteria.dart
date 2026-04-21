import 'package:eodb/src/db/database.dart';
import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/model/filter_mode.dart';
import 'package:eodb/src/model/item_criteria_filter.dart';
import 'package:eodb/src/widgets/database_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

    final percentageController = TextEditingController(
      text: filter.percentage.toString(),
    );

    var filterMode = filter.filterMode;

    void save() {
      setState(() {
        filter
          ..name = 'NEW'
          ..filterMode = filterMode;
      });
    }

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit filter'),
        content: Column(
          children: [
            Row(
              children: [
                const Expanded(child: Text('Percentage')),
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    controller: percentageController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: 'Any',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            ListTile(
              title: const Text('Filter mode'),
              trailing: SizedBox(
                width: 100,
                child: DropdownButtonFormField(
                  items: FilterMode.values
                      .map(
                        (mode) => DropdownMenuItem<FilterMode>(
                          value: mode,
                          child: Text(mode.displayName),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() => filterMode = value ?? FilterMode.equal);
                  },
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              save();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
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
