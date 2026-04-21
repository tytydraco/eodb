/// The model for the oil content of a compound.
class CompoundOilContentModel {
  /// Creates a new [CompoundOilContentModel].
  CompoundOilContentModel({
    required this.name,
    required this.percentage,
  });

  /// Creates a new [CompoundOilContentModel] from json.
  CompoundOilContentModel.fromJson(Map<String, dynamic> json)
    : name = json['name'] as String,
      percentage =
          (json['pivot'] as Map<String, dynamic>)['percentage_average']
              as double;

  /// The name of the oil.
  final String name;

  /// The percentage.
  final double percentage;

  /// Serialize to json.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'pivot': {
        'percentage_average',
      },
    };
  }
}
