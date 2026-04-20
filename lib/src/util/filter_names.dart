/// Filters a list of
Future<List<String>> filterNames({
  required List<String> names,
  required String criteria,
}) async {
  return names.where((name) => name.contains(criteria)).toList();
}
