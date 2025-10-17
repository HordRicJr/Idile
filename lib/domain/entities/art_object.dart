import 'package:equatable/equatable.dart';

/// Entity representing an African art object
class ArtObject extends Equatable {
  final String id;
  final String name;
  final String description;
  final String artist;
  final String period;
  final String material;
  final String technique;
  final String origin; // country/region of origin
  final String currentLocation; // current museum or collection
  final List<String> imageUrls;
  final String category; // sculpture, painting, textile, etc.
  final String culturalSignificance;
  final String dimensions;
  final bool isOnDisplay;

  const ArtObject({
    required this.id,
    required this.name,
    required this.description,
    required this.artist,
    required this.period,
    required this.material,
    required this.technique,
    required this.origin,
    required this.currentLocation,
    required this.imageUrls,
    required this.category,
    required this.culturalSignificance,
    required this.dimensions,
    required this.isOnDisplay,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        artist,
        period,
        material,
        technique,
        origin,
        currentLocation,
        imageUrls,
        category,
        culturalSignificance,
        dimensions,
        isOnDisplay,
      ];
}