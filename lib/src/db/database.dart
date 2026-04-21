import 'dart:convert';

import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/util/slugify.dart';
import 'package:flutter/services.dart';

/// Assets for compounds and oils.
class Database {
  // Private constructor necessary for singleton access.
  Database._();

  /// Singleton instance of the [Database].
  static final Database instance = Database._();

  /// The asset name for the list of compounds.
  static const compoundsListAsset = 'assets/eoscraper/compound_list.json';

  /// The asset name for the list of oils.
  static const oilsListAsset = 'assets/eoscraper/oil_list.json';

  /// The list of compounds in the list.
  final List<String> compoundNamesDb = [];

  /// The list of oils in the list.
  final List<String> oilNamesDb = [];

  /// Returns all names from the asset file.
  Future<List<String>> _namesFromAsset(String assetPath) async {
    final listCompounds = await rootBundle.loadString(assetPath);
    final names = (jsonDecode(listCompounds) as List<dynamic>)
        .cast<Map<String, dynamic>>();

    return names.map((e) {
      return e['name'] as String;
    }).toList();
  }

  /// Populates the compounds and oils name database.
  Future<void> populateNames() async {
    // Add all compounds.
    final compoundNames = await _namesFromAsset(Database.compoundsListAsset);
    compoundNamesDb
      ..clear()
      ..addAll(compoundNames);

    // Add all oils.
    final oilNames = await _namesFromAsset(Database.oilsListAsset);
    oilNamesDb
      ..clear()
      ..addAll(oilNames);
  }

  /// Returns the JSON content for an item by [name] and [type].
  Future<Map<String, dynamic>> loadItemJson(String name, ItemType type) async {
    final slug = slugify(name);
    final subpath = type == ItemType.compound ? 'compounds' : 'oils';
    final rawJson = await rootBundle.loadString(
      'assets/eoscraper/$subpath/$slug.json',
    );
    return jsonDecode(rawJson) as Map<String, dynamic>;
  }

  /// Returns a list of item names matching advanced criteria.
  Future<List<String>> filterItemsByCriteria() async {
    return [];
  }
}
