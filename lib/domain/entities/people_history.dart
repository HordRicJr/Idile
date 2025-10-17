import 'package:equatable/equatable.dart';

/// Entity representing the history of an African people/ethnic group
class PeopleHistory extends Equatable {
  final String id;
  final String peopleName;
  final String description;
  final String origin;
  final String currentLocation;
  final String language;
  final List<String> traditions;
  final List<String> keyEvents;
  final String culture;
  final String religion;
  final String economy;
  final List<String> imageUrls;
  final String period;
  final int population;

  const PeopleHistory({
    required this.id,
    required this.peopleName,
    required this.description,
    required this.origin,
    required this.currentLocation,
    required this.language,
    required this.traditions,
    required this.keyEvents,
    required this.culture,
    required this.religion,
    required this.economy,
    required this.imageUrls,
    required this.period,
    required this.population,
  });

  @override
  List<Object?> get props => [
        id,
        peopleName,
        description,
        origin,
        currentLocation,
        language,
        traditions,
        keyEvents,
        culture,
        religion,
        economy,
        imageUrls,
        period,
        population,
      ];
}