import 'dart:convert';

import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/model/compound_model.dart';
import 'package:eodb/src/model/oil_model.dart';
import 'package:eodb/src/model/search_criteria.dart';
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
  Future<List<String>> filterItemsByCriteria(SearchCriteria criteria) async {
    final type = criteria.type;
    final db = (type == ItemType.compound) ? compoundNamesDb : oilNamesDb;

    final jsons = await Future.wait(
      db.map((name) async => loadItemJson(name, type)).toList(),
    );

    switch (type) {
      // Compound.
      case ItemType.compound:
        final items = await Future.wait(
          jsons.map((json) async => CompoundModel.fromJson(json)),
        );

        final filteredItems = items.where((item) {
          // Name.
          if (criteria.name != null &&
              (criteria.name!.isEmpty ||
                  item.name.toLowerCase().contains(
                    criteria.name!.toLowerCase(),
                  ))) {
            return true;
          }

          // ID.
          if (criteria.id != null &&
              criteria.id!.isNotEmpty &&
              item.id != null &&
              item.id.toString() == criteria.id!) {
            return true;
          }

          // CAS #.
          if (criteria.cas != null &&
              criteria.cas!.isNotEmpty &&
              item.cas != null &&
              item.cas!.toLowerCase().contains(criteria.cas!.toLowerCase())) {
            return true;
          }

          // Item content.
          if (criteria.itemContentCriteria != null) {
            for (final itemCriteriaFilter in criteria.itemContentCriteria!) {
              final itemContentMatches = item.oilContent?.map((content) {
                // Name.
                if (itemCriteriaFilter.name != content.name) return false;

                // Compare percentages against filter mode.
                return itemCriteriaFilter.filterMode.compare(
                  itemCriteriaFilter.percentage,
                  content.percentage,
                );
              });
              if (itemContentMatches?.contains(false) ?? false) return false;
            }
          }

          return false;
        }).toList();

        return filteredItems.map((item) => item.name).toList();

      // Oil.
      case ItemType.oil:
        final items = await Future.wait(
          jsons.map((json) async => OilModel.fromJson(json)),
        );

        final filteredItems = items.where((item) {
          // Name.
          if (criteria.name != null &&
              (criteria.name!.isEmpty ||
                  item.name.toLowerCase().contains(
                    criteria.name!.toLowerCase(),
                  ))) {
            return true;
          }

          // ID.
          if (criteria.id != null &&
              criteria.id!.isNotEmpty &&
              item.id != null &&
              item.id.toString() == criteria.id!) {
            return true;
          }

          // Botanical name.
          if (criteria.botanicalName != null &&
              (criteria.botanicalName!.isEmpty ||
                  item.botanicalName!.toLowerCase().contains(
                    criteria.botanicalName!.toLowerCase(),
                  ))) {
            return true;
          }

          // CAS #.
          if (criteria.cas != null &&
              (criteria.cas!.isEmpty ||
                  item.cas!.toLowerCase().contains(
                    criteria.cas!.toLowerCase(),
                  ))) {
            return true;
          }

          // Publication author.
          if (criteria.publicationAuthor != null &&
              (criteria.publicationAuthor!.isEmpty ||
                  item.publicationAuthor!.toLowerCase().contains(
                    criteria.publicationAuthor!.toLowerCase(),
                  ))) {
            return true;
          }

          // Publication title.
          if (criteria.publicationTitle != null &&
              (criteria.publicationTitle!.isEmpty ||
                  item.publicationTitle!.toLowerCase().contains(
                    criteria.publicationTitle!.toLowerCase(),
                  ))) {
            return true;
          }

          // Publication date.
          if (criteria.publicationDate != null &&
              (criteria.publicationDate!.isEmpty ||
                  item.publicationDate!.toLowerCase().contains(
                    criteria.publicationDate!.toLowerCase(),
                  ))) {
            return true;
          }

          // Item content.
          print(criteria.itemContentCriteria);
          if (criteria.itemContentCriteria != null) {
            for (final itemCriteriaFilter in criteria.itemContentCriteria!) {
              final itemContentMatches = item.compoundContent?.map((content) {
                print(itemCriteriaFilter.name);
                print(itemCriteriaFilter.percentage);
                print(itemCriteriaFilter.type.displayName);

                // Name.
                if (itemCriteriaFilter.name != content.name) return false;

                // Compare percentages against filter mode.
                return itemCriteriaFilter.filterMode.compare(
                  itemCriteriaFilter.percentage,
                  content.percentage,
                );
              });
              if (itemContentMatches?.contains(false) ?? false) return false;
            }
          }

          return false;
        }).toList();

        return filteredItems.map((item) => item.name).toList();
    }
  }
}
