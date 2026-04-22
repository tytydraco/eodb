import 'package:eodb/src/db/storage.dart';
import 'package:flutter/material.dart';

/// A star icon to add or remove an item bookmark.
class BookmarkIconButton extends StatefulWidget {
  /// Creates a new [BookmarkIconButton].
  const BookmarkIconButton({
    required this.name,
    super.key,
  });

  /// The item name.
  final String name;

  @override
  State<BookmarkIconButton> createState() => _BookmarkIconButtonState();
}

class _BookmarkIconButtonState extends State<BookmarkIconButton> {
  @override
  Widget build(BuildContext context) {
    final isBookmarked = Storage.instance.bookmarkedNames.contains(widget.name);

    return IconButton(
      onPressed: () async {
        isBookmarked
            ? await Storage.instance.removeBookmark(widget.name)
            : await Storage.instance.addBookmark(widget.name);
        setState(() {});
      },
      icon: const Icon(Icons.star_border),
      selectedIcon: const Icon(Icons.star),
      isSelected: isBookmarked,
    );
  }
}
