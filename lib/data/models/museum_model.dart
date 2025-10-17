import '../../domain/entities/museum.dart';
import 'media_content_model.dart';

class MuseumModel extends Museum {
  const MuseumModel({
    required super.id,
    required super.name,
    required super.description,
    required super.address,
    required super.city,
    required super.country,
    required super.region,
    required super.imageUrl,
    required super.collections,
    required super.openingHours,
    required super.contactInfo,
    required super.rating,
    required super.website,
    required super.isVirtualTourAvailable,
    required super.mediaGallery,
    super.panorama360Url,
  });

  factory MuseumModel.fromJson(Map<String, dynamic> json) {
    return MuseumModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      region: json['region'] as String,
      imageUrl: json['image_url'] as String? ?? '',
      collections: List<String>.from(json['collections'] as List? ?? []),
      openingHours: json['opening_hours'] as String? ?? '',
      contactInfo: json['contact_info'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      website: json['website'] as String? ?? '',
      isVirtualTourAvailable: json['is_virtual_tour_available'] as bool? ?? false,
      mediaGallery: (json['media_gallery'] as List?)
              ?.map((e) => MediaContentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      panorama360Url: json['panorama_360_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'city': city,
      'country': country,
      'region': region,
      'image_url': imageUrl,
      'collections': collections,
      'opening_hours': openingHours,
      'contact_info': contactInfo,
      'rating': rating,
      'website': website,
      'is_virtual_tour_available': isVirtualTourAvailable,
      'media_gallery': mediaGallery.map((e) => (e as MediaContentModel).toJson()).toList(),
      'panorama_360_url': panorama360Url,
    };
  }
}