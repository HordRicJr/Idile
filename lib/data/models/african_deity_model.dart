import '../../domain/entities/african_deity.dart';

class AfricanDeityModel extends AfricanDeity {
  const AfricanDeityModel({
    required super.id,
    required super.name,
    required super.alternativeNames,
    required super.description,
    required super.mythology,
    required super.origin,
    required super.religion,
    required super.domain,
    required super.attributes,
    required super.symbols,
    required super.imageUrl,
    required super.stories,
    required super.worship,
    required super.significance,
    required super.family,
  });

  factory AfricanDeityModel.fromJson(Map<String, dynamic> json) {
    return AfricanDeityModel(
      id: json['id'] as String,
      name: json['name'] as String,
      alternativeNames: json['alternative_names'] as String? ?? '',
      description: json['description'] as String,
      mythology: json['mythology'] as String,
      origin: json['origin'] as String,
      religion: json['religion'] as String,
      domain: json['domain'] as String,
      attributes: List<String>.from(json['attributes'] as List? ?? []),
      symbols: List<String>.from(json['symbols'] as List? ?? []),
      imageUrl: json['image_url'] as String? ?? '',
      stories: List<String>.from(json['stories'] as List? ?? []),
      worship: json['worship'] as String? ?? '',
      significance: json['significance'] as String? ?? '',
      family: json['family'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'alternative_names': alternativeNames,
      'description': description,
      'mythology': mythology,
      'origin': origin,
      'religion': religion,
      'domain': domain,
      'attributes': attributes,
      'symbols': symbols,
      'image_url': imageUrl,
      'stories': stories,
      'worship': worship,
      'significance': significance,
      'family': family,
    };
  }
}