import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Widget du logo principal de l'application
class AppLogo extends StatelessWidget {
  final double width;
  final double height;
  final bool showText;

  const AppLogo({
    Key? key,
    this.width = 120,
    this.height = 120,
    this.showText = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo principal
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                AppColors.secondary,
                AppColors.accent,
              ],
              stops: const [0.0, 0.6, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Cercles décoratifs
              Positioned(
                top: height * 0.15,
                left: width * 0.2,
                child: Container(
                  width: width * 0.15,
                  height: width * 0.15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.background.withOpacity(0.3),
                  ),
                ),
              ),
              Positioned(
                bottom: height * 0.2,
                right: width * 0.25,
                child: Container(
                  width: width * 0.1,
                  height: width * 0.1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.background.withOpacity(0.4),
                  ),
                ),
              ),
              
              // Lettre I stylisée
              Text(
                'I',
                style: TextStyle(
                  fontSize: height * 0.4,
                  fontWeight: FontWeight.bold,
                  color: AppColors.background,
                  fontFamily: 'serif',
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        if (showText) ...[
          const SizedBox(height: 12),
          Text(
            'IDILE',
            style: TextStyle(
              fontSize: width * 0.15,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              letterSpacing: 2,
              fontFamily: 'serif',
            ),
          ),
        ],
      ],
    );
  }
}

/// Version compacte du logo pour les petits espaces
class AppLogoCompact extends StatelessWidget {
  final double width;
  final double height;

  const AppLogoCompact({
    Key? key,
    this.width = 60,
    this.height = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.secondary,
            AppColors.accent,
          ],
          stops: const [0.0, 0.6, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'I',
          style: TextStyle(
            fontSize: height * 0.4,
            fontWeight: FontWeight.bold,
            color: AppColors.background,
            fontFamily: 'serif',
          ),
        ),
      ),
    );
  }
}

/// Logo horizontal pour les barres d'applications
class AppLogoHorizontal extends StatelessWidget {
  final double height;

  const AppLogoHorizontal({
    Key? key,
    this.height = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppLogoCompact(
          width: height,
          height: height,
        ),
        const SizedBox(width: 12),
        Text(
          'IDILE',
          style: TextStyle(
            fontSize: height * 0.5,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
            letterSpacing: 1,
            fontFamily: 'serif',
          ),
        ),
      ],
    );
  }
}