import '../../domain/entities/african_festival.dart';

/// Data Transfer Object for African Festival
class AfricanFestivalModel extends AfricanFestival {
  const AfricanFestivalModel({
    required super.id,
    required super.name,
    required super.description,
    required super.origin,
    required super.period,
    required super.frequency,
    required super.purpose,
    required super.activities,
    required super.participants,
    required super.significance,
    required super.history,
    required super.traditions,
    required super.modernPractice,
    required super.imageUrl,
    required super.mediaUrls,
  });

  /// Create AfricanFestivalModel from JSON
  factory AfricanFestivalModel.fromJson(Map<String, dynamic> json) {
    return AfricanFestivalModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      origin: json['country'] as String? ?? json['origin'] as String? ?? 'Unknown',
      period: json['period'] as String,
      frequency: json['frequency'] as String? ?? 'Annual',
      purpose: json['purpose'] as String? ?? 'Cultural',
      activities: (json['activities'] as List<dynamic>?)?.cast<String>() ?? [],
      participants: (json['participants'] as List<dynamic>?)?.cast<String>() ?? 
                   [json['participants'] as String? ?? 'Community'],
      significance: json['significance'] as String? ?? '',
      history: json['history'] as String? ?? '',
      traditions: (json['traditions'] as List<dynamic>?)?.cast<String>() ?? [],
      modernPractice: json['modernPractice'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      mediaUrls: (json['mediaUrls'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  /// Convert AfricanFestivalModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'country': origin,
      'origin': origin,
      'period': period,
      'frequency': frequency,
      'purpose': purpose,
      'activities': activities,
      'participants': participants,
      'significance': significance,
      'history': history,
      'traditions': traditions,
      'modernPractice': modernPractice,
      'imageUrl': imageUrl,
      'mediaUrls': mediaUrls,
    };
  }
}