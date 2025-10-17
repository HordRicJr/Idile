import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/navigation/app_router.dart';

/// Page for exploring African heritage categories
class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome message
            _buildWelcomeMessage(context),
            const SizedBox(height: 24),
            
            // Categories grid
            _buildCategoriesGrid(context),
          ],
        ),
      );
  }

  Widget _buildWelcomeMessage(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.8),
            AppColors.secondary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Découvrez l\'Afrique',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Explorez les richesses culturelles, historiques et spirituelles du continent africain',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textOnPrimary.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesGrid(BuildContext context) {
    final categories = [
      {
        'id': 'tales',
        'title': 'Folk Tales',
        'icon': Icons.auto_stories_outlined,
        'color': AppColors.primary,
        'description': 'Traditional stories and legends',
      },
      {
        'id': 'music',
        'title': 'Traditional Music',
        'icon': Icons.music_note_outlined,
        'color': AppColors.secondary,
        'description': 'Rhythms and melodies of Africa',
      },
      {
        'id': 'figures',
        'title': 'Historical Figures',
        'icon': Icons.person_outline,
        'color': AppColors.accent,
        'description': 'Legendary leaders and heroes',
      },
      {
        'id': 'sites',
        'title': 'Ancient Sites',
        'icon': Icons.location_city_outlined,
        'color': AppColors.secondary,
        'description': 'Historical monuments and places',
      },
      {
        'id': 'festivals',
        'title': 'Cultural Festivals',
        'icon': Icons.celebration_outlined,
        'color': AppColors.accentSecondary,
        'description': 'Traditional celebrations',
      },
      {
        'id': 'art',
        'title': 'Art & Artifacts',
        'icon': Icons.palette_outlined,
        'color': AppColors.primary,
        'description': 'Traditional crafts and art',
      },
      {
        'id': 'kingdoms',
        'title': 'African Kingdoms',
        'icon': Icons.castle_outlined,
        'color': AppColors.accent,
        'description': 'Great empires and dynasties',
      },
      {
        'id': 'museums',
        'title': 'Museums',
        'icon': Icons.museum_outlined,
        'color': AppColors.secondary,
        'description': 'Cultural institutions',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Catégories',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryCard(
              context,
              categoryId: category['id'] as String,
              title: category['title'] as String,
              description: category['description'] as String,
              icon: category['icon'] as IconData,
              color: category['color'] as Color,
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required String categoryId,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: AppColors.surface,
      child: InkWell(
        onTap: () {
          AppNavigator.navigateToCategory(context, categoryId, title);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}