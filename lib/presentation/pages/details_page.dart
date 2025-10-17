import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Page for displaying detailed information about a specific item
class DetailsPage extends StatelessWidget {
  final String itemId;
  final String itemName;

  const DetailsPage({
    Key? key,
    required this.itemId,
    required this.itemName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(itemName),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 2,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _shareItem(context),
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image/header
            _buildHeroSection(context),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and subtitle
                  _buildTitleSection(context),
                  const SizedBox(height: 24),
                  
                  // Main content
                  _buildMainContent(context),
                  const SizedBox(height: 24),
                  
                  // Additional info
                  _buildAdditionalInfo(context),
                  const SizedBox(height: 24),
                  
                  // Related items
                  _buildRelatedItems(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Pattern overlay
          Positioned.fill(
            child: CustomPaint(
              painter: _AfricanPatternPainter(),
            ),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getItemIcon(itemId),
                    size: 48,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    itemName,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    final itemData = _getItemData(itemId);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          itemData['title'] as String,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          itemData['subtitle'] as String,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.accent.withOpacity(0.3),
            ),
          ),
          child: Text(
            itemData['category'] as String,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context) {
    final itemData = _getItemData(itemId);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          itemData['description'] as String,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          itemData['fullContent'] as String,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalInfo(BuildContext context) {
    final itemData = _getItemData(itemId);
    final info = itemData['additionalInfo'] as Map<String, String>;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informations supplémentaires',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.accent.withOpacity(0.2),
            ),
          ),
          child: Column(
            children: info.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        entry.key,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textLight,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRelatedItems(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contenus similaires',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.accent.withOpacity(0.2),
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.explore_outlined,
                size: 48,
                color: AppColors.textLight,
              ),
              const SizedBox(height: 16),
              Text(
                'Contenu en cours de développement',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Nous travaillons pour vous proposer des contenus similaires et enrichir votre expérience.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textLight,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _shareItem(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          'Partager',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Partagez cette découverte de l\'héritage africain avec vos proches.',
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              itemName,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Fermer',
              style: TextStyle(color: AppColors.secondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Lien copié dans le presse-papier'),
                  backgroundColor: AppColors.secondary,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.surface,
            ),
            child: const Text('Copier le lien'),
          ),
        ],
      ),
    );
  }

  IconData _getItemIcon(String itemId) {
    if (itemId.contains('tale')) return Icons.auto_stories;
    if (itemId.contains('figure')) return Icons.person;
    if (itemId.contains('site')) return Icons.location_city;
    if (itemId.contains('festival')) return Icons.celebration;
    if (itemId.contains('art')) return Icons.palette;
    if (itemId.contains('kingdom')) return Icons.castle;
    if (itemId.contains('music')) return Icons.music_note;
    return Icons.article;
  }

  Map<String, dynamic> _getItemData(String itemId) {
    // Mock data - replace with actual data service
    final mockData = {
      'tale_1': {
        'title': 'Anansi et la sagesse',
        'subtitle': 'Conte Akan du Ghana',
        'category': 'Contes Traditionnels',
        'description': 'L\'histoire de l\'araignée qui voulait garder toute la sagesse du monde pour elle-même.',
        'fullContent': 'Il était une fois Anansi, l\'araignée rusée, qui décida qu\'elle voulait posséder toute la sagesse du monde. Elle collecta soigneusement toute la sagesse dans une grande calebasse et décida de la cacher au sommet du plus grand arbre de la forêt. Mais en grimpant avec la calebasse attachée à son ventre, Anansi eut beaucoup de difficultés. Son jeune fils, qui l\'observait depuis le bas, lui suggéra d\'attacher la calebasse à son dos au lieu de son ventre. Réalisant que même son enfant possédait de la sagesse qu\'il n\'avait pas collectée, Anansi lâcha accidentellement la calebasse, répandant la sagesse aux quatre vents. C\'est ainsi que la sagesse se répandit dans le monde entier, accessible à tous ceux qui la cherchent.',
        'additionalInfo': {
          'Origine': 'Peuple Akan, Ghana',
          'Type': 'Conte moral',
          'Thème': 'Sagesse et humilité',
          'Transmission': 'Tradition orale',
        },
      },
      'figure_1': {
        'title': 'Mansa Musa',
        'subtitle': 'Empereur du Mali (1312-1337)',
        'category': 'Figures Historiques',
        'description': 'L\'homme le plus riche de l\'histoire, connu pour son pèlerinage légendaire à La Mecque.',
        'fullContent': 'Mansa Musa, dont le nom complet était Musa Keita I, régna sur l\'Empire du Mali de 1312 à 1337. Il est considéré comme l\'une des personnes les plus riches de l\'histoire de l\'humanité, grâce aux vastes réserves d\'or et de sel de son empire. Son célèbre pèlerinage à La Mecque en 1324-1325 a marqué l\'histoire. Il voyagea avec une caravane de 60 000 hommes, incluant 12 000 esclaves portant chacun 4 livres d\'or. Sa générosité était si grande qu\'il distribua tellement d\'or au Caire et à Médine que le prix de ce métal précieux s\'effondra pendant une décennie. Ce pèlerinage a mis l\'Empire du Mali sur la carte du monde connu et a établi des relations commerciales durables avec l\'Afrique du Nord et le Moyen-Orient.',
        'additionalInfo': {
          'Règne': '1312-1337',
          'Empire': 'Mali',
          'Religion': 'Islam',
          'Héritage': 'Commerce transsaharien',
        },
      },
    };

    return mockData[itemId] ?? {
      'title': itemName,
      'subtitle': 'Élément du patrimoine africain',
      'category': 'Héritage Culturel',
      'description': 'Découvrez cet élément fascinant de l\'héritage africain.',
      'fullContent': 'Le contenu détaillé pour cet élément est en cours de développement. Nous travaillons activement pour vous offrir une expérience riche et authentique.',
      'additionalInfo': {
        'Status': 'En développement',
        'Type': 'Patrimoine culturel',
      },
    };
  }
}

/// Custom painter for African-inspired patterns
class _AfricanPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textOnPrimary.withOpacity(0.1)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // Draw traditional African geometric patterns
    for (double i = 0; i <= size.width; i += 40) {
      for (double j = 0; j <= size.height; j += 40) {
        // Draw diamond shapes
        final path = Path();
        path.moveTo(i + 20, j);
        path.lineTo(i + 40, j + 20);
        path.lineTo(i + 20, j + 40);
        path.lineTo(i, j + 20);
        path.close();
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}