import 'package:equatable/equatable.dart';

/// Entity representing an African kingdom/empire
class AfricanKingdom extends Equatable {
  final String id;
  final String name;
  final String description;
  final String foundedDate;
  final String endDate;
  final String location;
  final String region;
  final List<String> territories; // territories controlled
  final String capital;
  final List<String> rulers; // famous rulers
  final String government; // type of government
  final String economy; // main economic activities
  final String culture; // cultural achievements
  final String military; // military organization
  final String decline; // reasons for decline
  final String legacy; // lasting impact
  final String imageUrl;
  final List<String> achievements;

  const AfricanKingdom({
    required this.id,
    required this.name,
    required this.description,
    required this.foundedDate,
    required this.endDate,
    required this.location,
    required this.region,
    required this.territories,
    required this.capital,
    required this.rulers,
    required this.government,
    required this.economy,
    required this.culture,
    required this.military,
    required this.decline,
    required this.legacy,
    required this.imageUrl,
    required this.achievements,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        foundedDate,
        endDate,
        location,
        region,
        territories,
        capital,
        rulers,
        government,
        economy,
        culture,
        military,
        decline,
        legacy,
        imageUrl,
        achievements,
      ];

  factory AfricanKingdom.fromJson(Map<String, dynamic> json) {
    return AfricanKingdom(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      foundedDate: json['foundedDate'] ?? '',
      endDate: json['endDate'] ?? '',
      location: json['location'] ?? '',
      region: json['region'] ?? '',
      territories: List<String>.from(json['territories'] ?? []),
      capital: json['capital'] ?? '',
      rulers: List<String>.from(json['rulers'] ?? []),
      government: json['government'] ?? '',
      economy: json['economy'] ?? '',
      culture: json['culture'] ?? '',
      military: json['military'] ?? '',
      decline: json['decline'] ?? '',
      legacy: json['legacy'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      achievements: List<String>.from(json['achievements'] ?? []),
    );
  }
}