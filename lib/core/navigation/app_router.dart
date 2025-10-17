import 'package:flutter/material.dart';
import '../../presentation/widgets/main_scaffold.dart';
import '../../presentation/pages/category_page.dart';
import '../../presentation/pages/details_page.dart';
import '../../presentation/pages/splash_screen.dart';
import '../../presentation/pages/welcome_screen.dart';

/// Routes definition for the African Heritage App
class AppRoutes {
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String home = '/';
  static const String explore = '/explore';
  static const String category = '/category';
  static const String details = '/details';
  static const String categories = '/categories';

  /// Generate routes based on settings
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
        
      case welcome:
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        );
        
      case home:
        return MaterialPageRoute(
          builder: (_) => const MainScaffold(initialIndex: 0),
        );
        
      case explore:
        return MaterialPageRoute(
          builder: (_) => const MainScaffold(initialIndex: 1),
        );
        
      case categories:
        return MaterialPageRoute(
          builder: (_) => const MainScaffold(initialIndex: 2),
        );
        
      case category:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => CategoryPage(
            categoryId: args?['category'] ?? 'all',
          ),
        );
        
      case details:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => DetailsPage(
            itemId: args?['itemId'] ?? '',
            itemName: args?['itemName'] ?? '',
          ),
        );
        
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page non trouvée'),
            ),
          ),
        );
    }
  }
}

/// Navigation helper methods
class AppNavigator {
  /// Navigate to explore page
  static void navigateToExplore(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.explore);
  }

  /// Navigate to category page
  static void navigateToCategory(
    BuildContext context,
    String categoryId,
    String categoryName,
  ) {
    Navigator.pushNamed(
      context,
      AppRoutes.category,
      arguments: {
        'categoryId': categoryId,
        'categoryName': categoryName,
      },
    );
  }

  /// Navigate to details page
  static void navigateToDetails(
    BuildContext context,
    String itemId,
    String itemName,
  ) {
    Navigator.pushNamed(
      context,
      AppRoutes.details,
      arguments: {
        'itemId': itemId,
        'itemName': itemName,
      },
    );
  }

  /// Navigate back
  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}

/// Route constants for consistent navigation
class AppRouter {
  static const String home = '/';
  static const String explore = '/explore';
  static const String category = '/category';
  static const String categories = '/categories';
  static const String details = '/details';
}