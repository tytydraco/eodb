/// Extension on [String] to add capitalization.
extension CapitalizeString on String {
  /// Capitalize the first letter of the string.
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
