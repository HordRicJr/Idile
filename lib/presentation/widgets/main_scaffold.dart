import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'custom_bottom_nav_bar.dart';
import 'custom_drawer.dart';
import '../pages/home_page.dart';
import '../pages/explore_page.dart';
import '../pages/categories_overview_page.dart';

/// Main scaffold that manages navigation between primary app sections
class MainScaffold extends StatefulWidget {
  final int initialIndex;

  const MainScaffold({
    Key? key,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late int _currentIndex;
  late PageController _pageController;

  final List<String> _titles = [
    'Accueil - Idile',
    'Explorer',
    'Catégories',
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _titles[_currentIndex],
        showSearch: true,
        onSearchTap: _handleSearch,
      ),
      drawer: const CustomDrawer(),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [
          HomePage(),
          ExplorePage(),
          CategoriesOverviewPage(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTap,
      ),
    );
  }

  void _handleSearch() {
    // This will trigger the search dialog from CustomAppBar
    // Search functionality is handled there
  }
}