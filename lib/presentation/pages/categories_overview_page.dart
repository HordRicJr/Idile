import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/navigation/app_router.dart';

/// Page showing all available categories for exploration
class CategoriesOverviewPage extends StatelessWidget {
  const CategoriesOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          _buildHeaderSection(context),
          const SizedBox(height: 24),
          
          // Categories Grid
          _buildCategoriesGrid(context),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.8),
            AppColors.secondary.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.category,
            color: AppColors.textOnPrimary,
            size: 32,
          ),
          const SizedBox(height: 12),
          Text(
            'Explore Our Categories',
            style: TextStyle(
              color: AppColors.textOnPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Discover the richness of African heritage through our various collections.',
            style: TextStyle(
              color: AppColors.textOnPrimary.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesGrid(BuildContext context) {
    final categories = [
      CategoryData(
        id: 'tales',
        title: 'African Tales',
        description: 'Traditional stories and popular tales',
        icon: Icons.auto_stories,
        color: AppColors.primary,
        itemCount: '25+ tales',
      ),
      CategoryData(
        id: 'historical-figures',
        title: 'Historical Figures',
        description: 'Heroes, leaders and emblematic figures',
        icon: Icons.person_outline,
        color: AppColors.secondary,
        itemCount: '15+ figures',
      ),
      CategoryData(
        id: 'festivals',
        title: 'Festivals & Traditions',
        description: 'Celebrations and cultural traditions',
        icon: Icons.festival,
        color: AppColors.accent,
        itemCount: '20+ festivals',
      ),
      CategoryData(
        id: 'kingdoms',
        title: 'African Kingdoms',
        description: 'Historical empires and kingdoms',
        icon: Icons.account_balance,
        color: AppColors.primary,
        itemCount: '12+ kingdoms',
      ),
      CategoryData(
        id: 'music',
        title: 'African Music',
        description: 'Instruments, rhythms and musical genres',
        icon: Icons.music_note,
        color: AppColors.secondary,
        itemCount: '30+ pieces',
      ),
      CategoryData(
        id: 'art',
        title: 'Art & Culture',
        description: 'Artworks and cultural expressions',
        icon: Icons.palette,
        color: AppColors.accent,
        itemCount: '40+ artworks',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return _buildCategoryCard(context, categories[index]);
      },
    );
  }

  Widget _buildCategoryCard(BuildContext context, CategoryData category) {
    return GestureDetector(
      onTap: () => _navigateToCategory(context, category),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: category.color.withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Icon(
                  category.icon,
                  size: 40,
                  color: category.color,
                ),
              ),
            ),
            
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.title,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category.description,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.collections,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          category.itemCount,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCategory(BuildContext context, CategoryData category) {
    Navigator.pushNamed(
      context,
      AppRouter.category,
      arguments: {
        'categoryId': category.id,
        'categoryName': category.title,
      },
    );
  }
}

/// Data class for category information
class CategoryData {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String itemCount;

  const CategoryData({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.itemCount,
  });
}