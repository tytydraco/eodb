import 'package:eodb/src/enum/item_type.dart';
import 'package:eodb/src/screens/advanced_search/item_content_criteria.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The advanced search screen.
class AdvancedSearchScreen extends StatefulWidget {
  /// Creates a new [AdvancedSearchScreen].
  const AdvancedSearchScreen({super.key});

  @override
  State<AdvancedSearchScreen> createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends State<AdvancedSearchScreen> {
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _botanicalNameController = TextEditingController();
  final _casController = TextEditingController();
  final _publicationAuthorController = TextEditingController();
  final _publicationTitleController = TextEditingController();
  final _publicationDateController = TextEditingController();

  Widget _inputTile({
    required TextEditingController controller,
    required String title,
    String? subtitle,
    bool digitsOnly = false,
  }) {
    final inputFormatters = digitsOnly
        ? [FilteringTextInputFormatter.digitsOnly]
        : null;
    final keyboardType = digitsOnly ? TextInputType.number : null;

    return ListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: SizedBox(
        width: 200,
        child: TextFormField(
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          controller: controller,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            hintText: 'Any',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Search'),
      ),
      body: ListView(
        children: [
          _inputTile(
            controller: _idController,
            title: 'ID',
            digitsOnly: true,
          ),
          const Divider(),
          _inputTile(
            controller: _nameController,
            title: 'Name',
          ),
          const Divider(),
          _inputTile(
            controller: _botanicalNameController,
            title: 'Botanical name',
          ),
          const Divider(),
          _inputTile(
            controller: _casController,
            title: 'CAS #',
          ),
          const Divider(),
          _inputTile(
            controller: _publicationAuthorController,
            title: 'Publication author',
          ),
          const Divider(),
          _inputTile(
            controller: _publicationTitleController,
            title: 'Publication title',
          ),
          const Divider(),
          _inputTile(
            controller: _publicationDateController,
            title: 'Publication date',
          ),
          const Divider(),

          const ItemContentCriteria(type: ItemType.compound),
        ],
      ),
    );
  }
}
