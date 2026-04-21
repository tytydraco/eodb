/// The model for the percentage-based content for an item.
class ContentModel {
  /// Creates a new [ContentModel].
  ContentModel({
    required this.name,
    required this.percentage,
  });

  /// Creates a new [ContentModel] from json.
  ContentModel.fromJson(Map<String, dynamic> json)
    : name = json['name'] as String,
      percentage =
          (json['pivot'] as Map<String, dynamic>)['percentage_average']
              as double;

  /// The name of the item.
  final String name;

  /// The percentage.
  final double percentage;
}
