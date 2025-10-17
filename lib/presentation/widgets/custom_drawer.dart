import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/navigation/app_router.dart';

/// Custom drawer menu for navigation and additional features
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: Column(
        children: [
          // Drawer Header with African-inspired design
          _buildDrawerHeader(context),
          
          // Navigation Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuSection(
                  context,
                  title: 'Contenu Principal',
                  items: [
                    _DrawerMenuItem(
                      icon: Icons.home,
                      title: 'Accueil',
                      onTap: () => Navigator.pushReplacementNamed(context, AppRouter.home),
                    ),
                    _DrawerMenuItem(
                      icon: Icons.explore,
                      title: 'Explorer',
                      onTap: () => Navigator.pushReplacementNamed(context, AppRouter.explore),
                    ),
                    _DrawerMenuItem(
                      icon: Icons.category,
                      title: 'Catégories',
                      onTap: () => Navigator.pushReplacementNamed(context, AppRouter.categories),
                    ),
                  ],
                ),
                
                Divider(color: AppColors.border),
                
                _buildMenuSection(
                  context,
                  title: 'Catalogues Spécialisés',
                  items: [
                    _DrawerMenuItem(
                      icon: Icons.auto_stories,
                      title: 'African Tales',
                      subtitle: 'Histoires traditionnelles',
                      onTap: () => _navigateToCategory(context, 'tales'),
                    ),
                    _DrawerMenuItem(
                      icon: Icons.person_outline,
                      title: 'Historical Figures',
                      subtitle: 'Héros et leaders',
                      onTap: () => _navigateToCategory(context, 'historical-figures'),
                    ),
                    _DrawerMenuItem(
                      icon: Icons.festival,
                      title: 'Festivals & Traditions',
                      subtitle: 'Célébrations africaines',
                      onTap: () => _navigateToCategory(context, 'festivals'),
                    ),
                    _DrawerMenuItem(
                      icon: Icons.account_balance,
                      title: 'African Kingdoms',
                      subtitle: 'Historical empires',
                      onTap: () => _navigateToCategory(context, 'kingdoms'),
                    ),
                    _DrawerMenuItem(
                      icon: Icons.music_note,
                      title: 'African Music',
                      subtitle: 'Sons et rythmes',
                      onTap: () => _navigateToCategory(context, 'music'),
                    ),
                    _DrawerMenuItem(
                      icon: Icons.palette,
                      title: 'Art & Culture',
                      subtitle: 'Artistic creations',
                      onTap: () => _navigateToCategory(context, 'art'),
                    ),
                    _DrawerMenuItem(
                      icon: Icons.format_quote,
                      title: 'African Quotes',
                      subtitle: 'Sagesse ancestrale',
                      onTap: () => _navigateToCategory(context, 'quotes'),
                    ),
                    _DrawerMenuItem(
                      icon: Icons.temple_buddhist,
                      title: 'African Deities',
                      subtitle: 'Mythologie et spiritualité',
                      onTap: () => _navigateToCategory(context, 'deities'),
                    ),
                    _DrawerMenuItem(
                      icon: Icons.location_city,
                      title: 'Historical Sites',
                      subtitle: 'African Heritage',
                      onTap: () => _navigateToCategory(context, 'sites'),
                    ),
                    _DrawerMenuItem(
                      icon: Icons.museum,
                      title: 'Museums',
                      subtitle: 'Collections culturelles',
                      onTap: () => _navigateToCategory(context, 'museums'),
                    ),
                  ],
                ),
                
                Divider(color: AppColors.border),
                
                _buildMenuSection(
                  context,
                  title: 'Autres',
                  items: [
                    _DrawerMenuItem(
                      icon: Icons.settings,
                      title: 'Paramètres',
                      onTap: () => Navigator.pop(context),
                    ),
                    _DrawerMenuItem(
                      icon: Icons.help_outline,
                      title: 'Aide & Support',
                      onTap: () => Navigator.pop(context),
                    ),
                    _DrawerMenuItem(
                      icon: Icons.info_outline,
                      title: 'À propos',
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Footer
          _buildDrawerFooter(context),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.secondary,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo/Icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.textOnPrimary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Icon(
                  Icons.landscape,
                  size: 36,
                  color: AppColors.textOnPrimary,
                ),
              ),
              const SizedBox(height: 16),
              
              // App Name
              Text(
                'Idile',
                style: TextStyle(
                  color: AppColors.textOnPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'African Heritage',
                style: TextStyle(
                  color: AppColors.textOnPrimary.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuSection(
    BuildContext context, {
    required String title,
    required List<_DrawerMenuItem> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        ...items.map((item) => _buildMenuItem(context, item)),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, _DrawerMenuItem item) {
    return ListTile(
      leading: Icon(
        item.icon,
        color: AppColors.primary,
        size: 24,
      ),
      title: Text(
        item.title,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: item.subtitle != null 
        ? Text(
            item.subtitle!,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          )
        : null,
      onTap: () {
        Navigator.pop(context);
        item.onTap();
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildDrawerFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
      ),
      child: Text(
        'Version 1.0.0\n© 2024 Idile App',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
        ),
      ),
    );
  }

  void _navigateToCategory(BuildContext context, String category) {
    Navigator.pushNamed(
      context,
      AppRouter.category,
      arguments: {'category': category},
    );
  }
}

/// Data class for drawer menu items
class _DrawerMenuItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _DrawerMenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });
}