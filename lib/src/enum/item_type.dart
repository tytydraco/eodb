/// An enum for the item type.
enum ItemType {
  /// A compound.
  compound('Compound'),

  /// An oil.
  oil('Oil');

  const ItemType(this.displayName);

  /// The display name for the item.
  final String displayName;
}
