import '../../domain/entities/historical_figure.dart';

/// Data Transfer Object for Historical Figure
class HistoricalFigureModel extends HistoricalFigure {
  const HistoricalFigureModel({
    required super.id,
    required super.name,
    required super.title,
    required super.biography,
    required super.birthDate,
    required super.deathDate,
    required super.country,
    required super.region,
    required super.imageUrl,
    required super.achievements,
    required super.period,
    required super.category,
  });

  /// Create HistoricalFigureModel from JSON
  factory HistoricalFigureModel.fromJson(Map<String, dynamic> json) {
    return HistoricalFigureModel(
      id: json['id'] as String,
      name: json['name'] as String,
      title: json['title'] as String? ?? '',
      biography: json['description'] as String? ?? json['biography'] as String? ?? '',
      birthDate: json['birthDate'] as String? ?? json['birthYear']?.toString() ?? 'Unknown',
      deathDate: json['deathDate'] as String? ?? json['deathYear']?.toString() ?? 'Unknown',
      country: json['country'] as String? ?? 'Unknown',
      region: json['region'] as String,
      imageUrl: json['imageUrl'] as String? ?? '',
      achievements: (json['achievements'] as List<dynamic>?)?.cast<String>() ?? [],
      period: json['period'] as String,
      category: json['category'] as String? ?? 'Historical Figure',
    );
  }

  /// Convert HistoricalFigureModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'description': biography,
      'biography': biography,
      'birthDate': birthDate,
      'deathDate': deathDate,
      'country': country,
      'region': region,
      'imageUrl': imageUrl,
      'achievements': achievements,
      'period': period,
      'category': category,
    };
  }
}