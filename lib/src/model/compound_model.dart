import 'package:eodb/src/db/database.dart';
import 'package:eodb/src/model/compound_oil_content_model.dart';

/// The model for a compound derived from the [Database].
class CompoundModel {
  /// Creates a new [CompoundModel].
  CompoundModel({
    required this.name,
    this.id,
    this.cas,
    this.imageUrl,
    this.oilContent,
  });

  /// Creates a new [CompoundModel] from [json] from EssentialOils.org.
  factory CompoundModel.fromJson(Map<String, dynamic> json) {
    final oils = (json['oil'] as List<dynamic>?)?.cast<Map<String, dynamic>>();
    final oilContent = oils
        ?.map(
          (oil) => CompoundOilContentModel(
            name: oil['name'] as String,
            percentage: double.parse(
              (oil['pivot'] as Map<String, dynamic>)['percentage_average']
                  as String,
            ),
          ),
        )
        .toList();

    return CompoundModel(
      id: json['id'] as int?,
      name: json['name'] as String,
      cas: json['CAS'] as String?,
      imageUrl: json['image_url'] as String?,
      oilContent: oilContent,
    );
  }

  /// The EssentialOils.org compound ID.
  final int? id;

  /// The name of the compound.
  final String name;

  /// The CAS Registry Number for the compound.
  final String? cas;

  /// The image URL associated with the compound.
  final String? imageUrl;

  /// The list of oils that the compound is present in.
  final List<CompoundOilContentModel>? oilContent;
}
