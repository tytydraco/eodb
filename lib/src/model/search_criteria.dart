import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/model/item_criteria_filter.dart';

/// A model for advanced search criteria.
class SearchCriteria {
  /// Creates a new [SearchCriteria].
  SearchCriteria({
    required this.type,
    this.id,
    this.name,
    this.botanicalName,
    this.cas,
    this.publicationAuthor,
    this.publicationTitle,
    this.publicationDate,
    this.itemContentCriteria,
  });

  /// The ID criteria.
  final String? id;

  /// The name criteria.
  final String? name;

  /// The botanical name criteria.
  final String? botanicalName;

  /// The CAS # criteria.
  final String? cas;

  /// The publication author criteria.
  final String? publicationAuthor;

  /// The publication title criteria.
  final String? publicationTitle;

  /// The publication date criteria.
  final String? publicationDate;

  /// The item type criteria.
  final ItemType type;

  /// The item content criteria.
  final List<ItemCriteriaFilter>? itemContentCriteria;
}
