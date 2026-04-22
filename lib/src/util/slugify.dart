import 'package:diacritic/diacritic.dart';

/// Converts the [content] to a slug.
String slugify(String content, {bool allowUnicode = false}) {
  var value = content;

  // Remove unicode if necessary.
  if (!allowUnicode) value = removeDiacritics(value);

  // Lowercase.
  value = value.toLowerCase();

  // Remove invalid chars (keep letters, numbers, whitespace, hyphen).
  value = value.replaceAll(RegExp(r'[^\w\s-]'), '');

  // Replace spaces & repeated hyphens with single hyphen.
  value = value.replaceAll(RegExp(r'[-\s]+'), '-');

  // Trim leading/trailing hyphens/underscores.
  value = value.replaceAll(RegExp(r'^[-_]+|[-_]+$'), '');

  return value;
}
