import '../../domain/entities/historical_site.dart';

class HistoricalSiteModel extends HistoricalSite {
  const HistoricalSiteModel({
    required super.id,
    required super.name,
    required super.description,
    required super.location,
    required super.country,
    required super.region,
    required super.period,
    required super.significance,
    required super.imageUrls,
    required super.category,
    required super.isUnescoSite,
    required super.visitInfo,
  });

  factory HistoricalSiteModel.fromJson(Map<String, dynamic> json) {
    return HistoricalSiteModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      country: json['country'] as String,
      region: json['region'] as String,
      period: json['period'] as String,
      significance: json['significance'] as String,
      imageUrls: List<String>.from(json['image_urls'] as List? ?? []),
      category: json['category'] as String,
      isUnescoSite: json['is_unesco_site'] as bool? ?? false,
      visitInfo: json['visit_info'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location': location,
      'country': country,
      'region': region,
      'period': period,
      'significance': significance,
      'image_urls': imageUrls,
      'category': category,
      'is_unesco_site': isUnescoSite,
      'visit_info': visitInfo,
    };
  }
}