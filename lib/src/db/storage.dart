import 'dart:collection';

import 'package:shared_preferences/shared_preferences.dart';

/// Manage shared preferences and persistent data.
class Storage {
  /// Private constructor necessary for singleton access.
  Storage._();

  /// The [SharedPreferences] key for the item bookmarks.
  static const _sharedPrefsKeyBookmarks = 'item_bookmarks';

  /// Singleton instance of the [Storage].
  static final Storage instance = Storage._();

  /// The names of bookmarked item names, from either compounds or oils.
  final bookmarkedNames = HashSet<String>();

  /// The [SharedPreferences] instance to use.
  SharedPreferences? _sharedPrefs;

  /// Save the [bookmarkedNames] to [_sharedPrefs].
  Future<void> _saveBookmarks() async {
    await initSharedPreferences();
    await _sharedPrefs?.setStringList(
      _sharedPrefsKeyBookmarks,
      bookmarkedNames.toList(),
    );
  }

  /// Initialize the [_sharedPrefs] instance.
  Future<void> initSharedPreferences() async {
    // Do not reinitialize.
    if (_sharedPrefs != null) return;

    _sharedPrefs = await SharedPreferences.getInstance();
  }

  /// Add a new item bookmark by [name].
  Future<void> addBookmark(String name) async {
    bookmarkedNames.add(name);
    await _saveBookmarks();
  }

  /// Remove an item bookmark by [name].
  Future<void> removeBookmark(String name) async {
    bookmarkedNames.remove(name);
    await _saveBookmarks();
  }
}
