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
    await _sharedPrefs!.setStringList(
      _sharedPrefsKeyBookmarks,
      bookmarkedNames.toList(),
    );
  }

  /// Initialize the [_sharedPrefs] instance and necessary values.
  Future<void> initSharedPreferences() async {
    // Do not reinitialize.
    if (_sharedPrefs != null) return;

    _sharedPrefs = await SharedPreferences.getInstance();

    final savedBookmarkedNames = _sharedPrefs!.getStringList(
      _sharedPrefsKeyBookmarks,
    );
    if (savedBookmarkedNames != null && savedBookmarkedNames.isNotEmpty) {
      bookmarkedNames.addAll(savedBookmarkedNames);
    }
  }

  /// Add a new item bookmark by [name].
  Future<void> addBookmark(String name) async {
    await initSharedPreferences();
    bookmarkedNames.add(name);
    await _saveBookmarks();
  }

  /// Remove an item bookmark by [name].
  Future<void> removeBookmark(String name) async {
    await initSharedPreferences();
    bookmarkedNames.remove(name);
    await _saveBookmarks();
  }

  /// Set an item's notes by [name] given the note's [content].
  Future<void> setNotes(String name, String content) async {
    await initSharedPreferences();
    final sharedPrefsKeyItemNote = '${name}_notes';
    await _sharedPrefs!.setString(sharedPrefsKeyItemNote, content);
  }

  /// Get an item's notes by [name].
  Future<String?> getNotes(String name) async {
    await initSharedPreferences();
    final sharedPrefsKeyItemNote = '${name}_notes';
    return _sharedPrefs!.getString(sharedPrefsKeyItemNote);
  }
}
