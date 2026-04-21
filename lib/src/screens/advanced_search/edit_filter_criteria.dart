import 'package:eodb/src/enum/filter_mode.dart';
import 'package:eodb/src/model/item_criteria_filter.dart';
import 'package:eodb/src/widgets/input_tile.dart';
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
  late final _percentageController = TextEditingController(
    text: widget.itemCriteriaFilter.percentage.toString(),
  );

  late final _filterModeController = TextEditingController(
    text: widget.itemCriteriaFilter.filterMode.displayName,
  );

  /// Save the filter and return the result to the caller.
  void _saveFilterAndReturn() {
    // Revert to default percentage if parsing fails.
    widget.itemCriteriaFilter.percentage =
        double.tryParse(_percentageController.text) ??
        widget.itemCriteriaFilter.percentage;

    // Match filter mode by display name.
    final filterModes = FilterMode.values.where(
      (mode) => mode.displayName == _filterModeController.text,
    );

    // Revert to default filter mode if matching fails.
    widget.itemCriteriaFilter.filterMode = filterModes.isNotEmpty
        ? filterModes.first
        : widget.itemCriteriaFilter.filterMode;

    // Return result to caller.
    Navigator.pop(
      context,
      widget.itemCriteriaFilter,
    );
  }

  /// Dropdown menu widget for the filter modes.
  Widget _filterModeDropdown() {
    // Map filter modes to entries.
    final dropdownMenuEntries = FilterMode.values
        .map(
          (filterMode) => DropdownMenuEntry(
            value: filterMode,
            label: filterMode.displayName,
          ),
        )
        .toList();

    return DropdownMenu<FilterMode>(
      controller: _filterModeController,
      width: 200,
      textAlign: TextAlign.center,
      dropdownMenuEntries: dropdownMenuEntries,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit filter'),
        actions: [
          IconButton(
            onPressed: _saveFilterAndReturn,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Name.
          ListTile(
            title: const Text('Name'),
            trailing: Text(widget.itemCriteriaFilter.name),
          ),
          const Divider(),

          // Filter mode.
          ListTile(
            title: const Text('Filter mode'),
            trailing: SizedBox(
              width: 200,
              child: _filterModeDropdown(),
            ),
          ),
          const Divider(),

          // Percentage.
          InputTile(
            controller: _percentageController,
            title: 'Percentage',
            hint: widget.itemCriteriaFilter.percentage.toString(),
            digitsOnly: true,
            decimalAllowed: true,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
