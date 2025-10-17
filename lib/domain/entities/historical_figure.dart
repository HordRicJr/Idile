import 'package:equatable/equatable.dart';

/// Entity representing an African historical figure
class HistoricalFigure extends Equatable {
  final String id;
  final String name;
  final String title;
  final String biography;
  final String birthDate;
  final String deathDate;
  final String country;
  final String region;
  final String imageUrl;
  final List<String> achievements;
  final String period;
  final String category; // king, queen, warrior, scholar, etc.

  const HistoricalFigure({
    required this.id,
    required this.name,
    required this.title,
    required this.biography,
    required this.birthDate,
    required this.deathDate,
    required this.country,
    required this.region,
    required this.imageUrl,
    required this.achievements,
    required this.period,
    required this.category,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        title,
        biography,
        birthDate,
        deathDate,
        country,
        region,
        imageUrl,
        achievements,
        period,
        category,
      ];

  factory HistoricalFigure.fromJson(Map<String, dynamic> json) {
    return HistoricalFigure(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      biography: json['biography'] ?? '',
      birthDate: json['birthDate'] ?? '',
      deathDate: json['deathDate'] ?? '',
      country: json['country'] ?? '',
      region: json['region'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      achievements: List<String>.from(json['achievements'] ?? []),
      period: json['period'] ?? '',
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'title': title,
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