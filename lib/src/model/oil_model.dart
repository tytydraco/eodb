import 'package:eodb/src/db/database.dart';

/// The model for a compound derived from the [Database].
class OilModel {
  /// Creates a new [OilModel].
  OilModel({
    required this.name,
    this.id,
    this.botanicalName,
    this.cas,
    this.imageUrl,
    this.publicationAuthor,
    this.publicationTitle,
    this.publicationDate,
  });

  /// Creates a new [OilModel] from [json] from EssentialOils.org.
  OilModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = json['name'] as String,
      botanicalName = json['name_botanical'] as String?,
      cas = json['CAS'] as String?,
      imageUrl = json['image_url'] as String?,
      publicationAuthor = json['abstract_author'] as String?,
      publicationTitle = json['abstract_title'] as String?,
      publicationDate = json['abstract_publication'] as String?;

  /// The EssentialOils.org oil ID.
  final int? id;

  /// The name of the oil.
  final String name;

  /// The botanical name of the oil.
  final String? botanicalName;

  /// The CAS Registry Number for the oil.
  final String? cas;

  /// The image URL associated with the oil.
  final String? imageUrl;

  /// The abstract publication author.
  final String? publicationAuthor;

  /// The abstract publication title.
  final String? publicationTitle;

  /// The abstract publication date.
  final String? publicationDate;
}
