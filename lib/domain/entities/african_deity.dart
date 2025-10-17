import 'package:equatable/equatable.dart';

/// Entity representing an African deity/god from various traditional religions
class AfricanDeity extends Equatable {
  final String id;
  final String name;
  final String alternativeNames;
  final String description;
  final String mythology;
  final String origin; // country/region of origin
  final String religion; // Yoruba, Egyptian, etc.
  final String domain; // what they govern (love, war, wisdom, etc.)
  final List<String> attributes;
  final List<String> symbols;
  final String imageUrl;
  final List<String> stories; // mythological stories
  final String worship; // how they were/are worshipped
  final String significance; // cultural importance
  final String family; // relationships with other deities

  const AfricanDeity({
    required this.id,
    required this.name,
    required this.alternativeNames,
    required this.description,
    required this.mythology,
    required this.origin,
    required this.religion,
    required this.domain,
    required this.attributes,
    required this.symbols,
    required this.imageUrl,
    required this.stories,
    required this.worship,
    required this.significance,
    required this.family,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        alternativeNames,
        description,
        mythology,
        origin,
        religion,
        domain,
        attributes,
        symbols,
        imageUrl,
        stories,
        worship,
        significance,
        family,
      ];
}