import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/model/filter_mode.dart';

/// A mutable model class for a filter option.
class ItemCriteriaFilter {
  /// Creates a new [ItemCriteriaFilter].
  ItemCriteriaFilter({
    required this.name,
    required this.type,
    required this.percentage,
    required this.filterMode,
  });

  /// The name of the item.
  String name;

  /// The type of the item.
  ItemType type;

  /// The criteria percentage.
  double percentage;

  /// The filter mode for the criteria.
  FilterMode filterMode;
}
