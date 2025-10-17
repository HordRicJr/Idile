import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/di/injection_container.dart';
import 'categories/tales_page.dart';
import 'categories/historical_figures_page.dart';
import 'categories/african_music_page.dart';
import 'categories/quotes_page.dart';
import 'categories/african_deities_page.dart';
import 'categories/historical_sites_page.dart';
import 'categories/museums_page.dart';
import 'categories/african_festivals_page.dart';
import 'categories/african_kingdoms_page.dart';
import 'categories/art_objects_page.dart';
import '../viewmodels/tale_viewmodel.dart';
import '../viewmodels/historical_figure_viewmodel.dart';
import '../viewmodels/african_festival_viewmodel.dart';
import '../viewmodels/african_kingdom_viewmodel.dart';
import '../viewmodels/african_music_viewmodel.dart';
import '../viewmodels/art_object_viewmodel.dart';
import '../viewmodels/quote_viewmodel.dart';
import '../viewmodels/african_deity_viewmodel.dart';
import '../viewmodels/historical_site_viewmodel.dart';
import '../viewmodels/museum_viewmodel.dart';

/// Router page for displaying specific category pages
class CategoryPage extends StatelessWidget {
  final String categoryId;

  const CategoryPage({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildCategoryPage(context);
  }

  Widget _buildCategoryPage(BuildContext context) {
    switch (categoryId) {
      case 'tales':
        return ChangeNotifierProvider(
          create: (_) => sl<TaleViewModel>(),
          child: const TalesPage(),
        );
      
      case 'historical-figures':
        return ChangeNotifierProvider(
          create: (_) => sl<HistoricalFigureViewModel>(),
          child: const HistoricalFiguresPage(),
        );
      
      case 'music':
        return ChangeNotifierProvider(
          create: (_) => sl<AfricanMusicViewModel>(),
          child: const AfricanMusicPage(),
        );
      
      case 'quotes':
        return ChangeNotifierProvider(
          create: (_) => sl<QuoteViewModel>(),
          child: const QuotesPage(),
        );
      
      case 'festivals':
        return ChangeNotifierProvider(
          create: (_) => sl<AfricanFestivalViewModel>(),
          child: const AfricanFestivalsPage(),
        );
      
      case 'kingdoms':
        return ChangeNotifierProvider(
          create: (_) => sl<AfricanKingdomViewModel>(),
          child: const AfricanKingdomsPage(),
        );
      
      case 'art':
        return ChangeNotifierProvider(
          create: (_) => sl<ArtObjectViewModel>(),
          child: const ArtObjectsPage(),
        );
      
      case 'deities':
        return ChangeNotifierProvider(
          create: (_) => sl<AfricanDeityViewModel>(),
          child: const AfricanDeitiesPage(),
        );
      
      case 'sites':
        return ChangeNotifierProvider(
          create: (_) => sl<HistoricalSiteViewModel>(),
          child: const HistoricalSitesPage(),
        );
      
      case 'museums':
        return ChangeNotifierProvider(
          create: (_) => sl<MuseumViewModel>(),
          child: const MuseumsPage(),
        );
      
      default:
        return _buildUnknownCategoryPage(context);
    }
  }



  Widget _buildUnknownCategoryPage(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Catégorie'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 2,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.red.withOpacity(0.2),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Catégorie inconnue',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'La catégorie "$categoryId" n\'existe pas.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textLight,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

}

