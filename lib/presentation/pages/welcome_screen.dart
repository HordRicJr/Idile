import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../widgets/app_logo.dart';

/// Welcome screen with application introduction
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  
  late PageController _pageController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  int _currentPage = 0;
  
  final List<WelcomeSlide> _slides = [
    WelcomeSlide(
      title: "Discover African Richness",
      subtitle: "Explore the cultural heritage of the African continent",
      description: "Dive into a fascinating journey through the traditions, art, history, and wisdom of Africa.",
      icon: Icons.explore,
      gradient: [AppColors.primary, AppColors.secondary],
    ),
    WelcomeSlide(
      title: "Journey Through Ancient Times",
      subtitle: "Discover lost civilizations",
      description: "Explore the great kingdoms, iconic historical figures, and sacred sites that shaped the continent.",
      icon: Icons.history,
      gradient: [AppColors.secondary, AppColors.accent],
    ),
    WelcomeSlide(
      title: "Listen to Ancestral Voices",
      subtitle: "Tales, music, and oral traditions",
      description: "Let yourself be carried away by ancestral stories, traditional melodies, and wisdom passed down through generations.",
      icon: Icons.music_note,
      gradient: [AppColors.accent, AppColors.accentSecondary],
    ),
    WelcomeSlide(
      title: "Celebrate Art and Festivals",
      subtitle: "Living culture and artistic expressions",
      description: "Immerse yourself in African artistic richness, from traditional art objects to colorful festivals that animate the continent.",
      icon: Icons.celebration,
      gradient: [AppColors.accentSecondary, AppColors.primary],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    
    // Start animations
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    _slideController.forward();
  }

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToHome();
    }
  }

  void _skipToHome() {
    _navigateToHome();
  }

  void _navigateToHome() {
    HapticFeedback.lightImpact();
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([_fadeController, _slideController]),
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Stack(
                children: [
                  // PageView for slides
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                      HapticFeedback.selectionClick();
                    },
                    itemCount: _slides.length,
                    itemBuilder: (context, index) {
                      return _buildSlide(_slides[index], index);
                    },
                  ),
                  
                  // Skip button at top right
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 16,
                    right: 20,
                    child: TextButton(
                      onPressed: _skipToHome,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.textLight,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8
                        ),
                      ),
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  
                  // Page indicators and next button
                  Positioned(
                    bottom: 50,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Page indicators
                          Row(
                            children: List.generate(
                              _slides.length,
                              (index) => _buildPageIndicator(index),
                            ),
                          ),
                          
                          // Next/finish button
                          FloatingActionButton(
                            onPressed: _nextPage,
                            backgroundColor: AppColors.accent,
                            foregroundColor: AppColors.textPrimary,
                            elevation: 8,
                            child: Icon(
                              _currentPage == _slides.length - 1
                                  ? Icons.check
                                  : Icons.arrow_forward,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSlide(WelcomeSlide slide, int index) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            slide.gradient[0].withOpacity(0.1),
            slide.gradient[1].withOpacity(0.05),
            AppColors.background,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Spacer(flex: 1),
              
              // Logo at top (only on first slide)
              if (index == 0) ...[
                const AppLogoCompact(
                  width: 80,
                  height: 80,
                ),
                const SizedBox(height: 20),
              ],
              
              // Slide icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: slide.gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: slide.gradient[0].withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  slide.icon,
                  size: 60,
                  color: AppColors.background,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Main title
              Text(
                slide.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Subtitle
              Text(
                slide.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: slide.gradient[0],
                  height: 1.3,
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  slide.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 8),
      width: _currentPage == index ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? AppColors.accent
            : AppColors.textLight.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

/// Model for welcome slides
class WelcomeSlide {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final List<Color> gradient;

  const WelcomeSlide({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.gradient,
  });
}