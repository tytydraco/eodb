/// An enum for the type of filtering to perform.
enum FilterMode {
  /// Must be greater than criteria.
  greaterThan('>'),

  /// Must be greater than or equal to criteria.
  greaterThanOrEqual('≥'),

  /// Must be less than criteria.
  lessThan('<'),

  /// Must be less than or equal to criteria.
  lessThanOrEqual('≤'),

  /// Must be equal to criteria.
  equal('='),

  /// Must not be equal to criteria.
  notEqual('≠');

  const FilterMode(this.displayName);

  /// The display name for the filter mode.
  final String displayName;
}
