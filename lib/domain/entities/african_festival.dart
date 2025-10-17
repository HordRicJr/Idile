import 'package:equatable/equatable.dart';

/// Entity representing an African traditional festival
class AfricanFestival extends Equatable {
  final String id;
  final String name;
  final String description;
  final String origin; // country/region
  final String period; // when it's celebrated
  final String frequency; // annual, seasonal, etc.
  final String purpose; // harvest, spiritual, cultural, etc.
  final List<String> activities; // ceremonies, dances, etc.
  final List<String> participants; // who participates
  final String significance; // cultural/spiritual importance
  final String history; // historical background
  final List<String> traditions; // specific traditions
  final String modernPractice; // how it's celebrated today
  final String imageUrl;
  final List<String> mediaUrls; // videos, audio of the festival

  const AfricanFestival({
    required this.id,
    required this.name,
    required this.description,
    required this.origin,
    required this.period,
    required this.frequency,
    required this.purpose,
    required this.activities,
    required this.participants,
    required this.significance,
    required this.history,
    required this.traditions,
    required this.modernPractice,
    required this.imageUrl,
    required this.mediaUrls,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        origin,
        period,
        frequency,
        purpose,
        activities,
        participants,
        significance,
        history,
        traditions,
        modernPractice,
        imageUrl,
        mediaUrls,
      ];

  factory AfricanFestival.fromJson(Map<String, dynamic> json) {
    return AfricanFestival(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      origin: json['origin'] ?? '',
      period: json['period'] ?? '',
      frequency: json['frequency'] ?? '',
      purpose: json['purpose'] ?? '',
      activities: List<String>.from(json['activities'] ?? []),
      participants: List<String>.from(json['participants'] ?? []),
      significance: json['significance'] ?? '',
      history: json['history'] ?? '',
      traditions: List<String>.from(json['traditions'] ?? []),
      modernPractice: json['modernPractice'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      mediaUrls: List<String>.from(json['mediaUrls'] ?? []),
    );
  }
}