import 'package:eodb/src/db/database.dart';
import 'package:eodb/src/db/storage.dart';
import 'package:eodb/src/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Populate the database with the item names.
  await Database.instance.populateNames();

  // Initialize the shared preferences instance.
  await Storage.instance.initSharedPreferences();
  
  runApp(const EODB());
}

/// Entry point for the app.
class EODB extends StatelessWidget {
  /// Creates a new [EODB].
  const EODB({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EODB',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const HomeScreen(),
    );
  }
}
