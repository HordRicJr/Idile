import '../../domain/entities/art_object.dart';

/// Data Transfer Object for Art Object
class ArtObjectModel extends ArtObject {
  const ArtObjectModel({
    required super.id,
    required super.name,
    required super.description,
    required super.artist,
    required super.period,
    required super.material,
    required super.technique,
    required super.origin,
    required super.currentLocation,
    required super.imageUrls,
    required super.category,
    required super.culturalSignificance,
    required super.dimensions,
    required super.isOnDisplay,
  });

  /// Create ArtObjectModel from JSON
  factory ArtObjectModel.fromJson(Map<String, dynamic> json) {
    return ArtObjectModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      artist: json['artist'] as String? ?? 'Unknown Artist',
      period: json['period'] as String? ?? 'Unknown Period',
      material: json['material'] as String? ?? json['materials'] as String? ?? 'Unknown',
      technique: json['technique'] as String? ?? 'Traditional',
      origin: json['origin'] as String,
      currentLocation: json['currentLocation'] as String? ?? json['location'] as String? ?? 'Unknown',
      imageUrls: (json['imageUrls'] as List<dynamic>?)?.cast<String>() ?? 
                 [json['imageUrl'] as String? ?? ''],
      category: json['category'] as String? ?? json['type'] as String? ?? 'Art Object',
      culturalSignificance: json['culturalSignificance'] as String? ?? json['significance'] as String? ?? '',
      dimensions: json['dimensions'] as String? ?? json['size'] as String? ?? 'Unknown',
      isOnDisplay: json['isOnDisplay'] as bool? ?? json['display'] as bool? ?? true,
    );
  }

  /// Convert ArtObjectModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'artist': artist,
      'period': period,
      'material': material,
      'technique': technique,
      'origin': origin,
      'currentLocation': currentLocation,
      'imageUrls': imageUrls,
      'category': category,
      'culturalSignificance': culturalSignificance,
      'dimensions': dimensions,
      'isOnDisplay': isOnDisplay,
    };
  }
}