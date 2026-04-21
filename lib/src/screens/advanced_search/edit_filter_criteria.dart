import 'package:eodb/src/model/item_criteria_filter.dart';
import 'package:flutter/material.dart';

/// Edit page for a created filter, returning the new filter.
class EditFilterCriteria extends StatefulWidget {
  /// Creates a new [EditFilterCriteria].
  const EditFilterCriteria({
    required this.itemCriteriaFilter,
    super.key,
  });

  /// The item filter.
  final ItemCriteriaFilter itemCriteriaFilter;

  @override
  State<EditFilterCriteria> createState() => _EditFilterCriteriaState();
}

class _EditFilterCriteriaState extends State<EditFilterCriteria> {
  Future<void> _saveFilterAndReturn() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit filter'),
        actions: [
          IconButton(
            onPressed: () => _saveFilterAndReturn,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
    );
  }
}
