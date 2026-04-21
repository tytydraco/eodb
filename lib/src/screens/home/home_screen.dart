import 'package:eodb/src/screens/home/tabs/compounds_tab.dart';
import 'package:eodb/src/screens/home/tabs/oils_tab.dart';
import 'package:flutter/material.dart';

/// The home screen.
class HomeScreen extends StatefulWidget {
  /// Creates a new [HomeScreen].
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  final List<Widget> _tabs = const [
    CompoundsTab(),
    OilsTab(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        onTap: (index) => setState(() => _tabController.index = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dangerous_outlined),
            label: 'Compounds',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.oil_barrel_outlined),
            label: 'Oils',
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: TabBarView(
          controller: _tabController,
          children: _tabs.map((tab) => Tab(child: tab)).toList(),
        ),
      ),
    );
  }
}
