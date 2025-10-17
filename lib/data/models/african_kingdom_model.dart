import '../../domain/entities/african_kingdom.dart';

/// Data Transfer Object for African Kingdom
class AfricanKingdomModel extends AfricanKingdom {
  const AfricanKingdomModel({
    required super.id,
    required super.name,
    required super.description,
    required super.foundedDate,
    required super.endDate,
    required super.location,
    required super.region,
    required super.territories,
    required super.capital,
    required super.rulers,
    required super.government,
    required super.economy,
    required super.culture,
    required super.military,
    required super.decline,
    required super.legacy,
    required super.imageUrl,
    required super.achievements,
  });

  /// Create AfricanKingdomModel from JSON
  factory AfricanKingdomModel.fromJson(Map<String, dynamic> json) {
    return AfricanKingdomModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      foundedDate: json['foundedDate'] as String? ?? json['period']?.toString().split('-').first ?? 'Unknown',
      endDate: json['endDate'] as String? ?? json['period']?.toString().split('-').last ?? 'Unknown',
      location: json['location'] as String? ?? json['region'] as String? ?? 'Unknown',
      region: json['region'] as String,
      territories: (json['territories'] as List<dynamic>?)?.cast<String>() ?? [],
      capital: json['capital'] as String? ?? 'Unknown',
      rulers: (json['rulers'] as List<dynamic>?)?.cast<String>() ?? [],
      government: json['government'] as String? ?? 'Monarchy',
      economy: json['economy'] as String? ?? '',
      culture: json['culture'] as String? ?? '',
      military: json['military'] as String? ?? '',
      decline: json['decline'] as String? ?? '',
      legacy: json['legacy'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      achievements: (json['achievements'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  /// Convert AfricanKingdomModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'foundedDate': foundedDate,
      'endDate': endDate,
      'location': location,
      'region': region,
      'territories': territories,
      'capital': capital,
      'rulers': rulers,
      'government': government,
      'economy': economy,
      'culture': culture,
      'military': military,
      'decline': decline,
      'legacy': legacy,
      'imageUrl': imageUrl,
      'achievements': achievements,
      'period': '$foundedDate - $endDate',
    };
  }
}