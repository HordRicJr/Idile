import 'package:equatable/equatable.dart';
import 'media_content.dart';

/// Entity representing an African museum
class Museum extends Equatable {
  final String id;
  final String name;
  final String description;
  final String address;
  final String city;
  final String country;
  final String region;
  final String imageUrl;
  final List<String> collections;
  final String openingHours;
  final String contactInfo;
  final double rating;
  final String website;
  final bool isVirtualTourAvailable;
  final List<MediaContent> mediaGallery;
  final String? panorama360Url;

  const Museum({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.city,
    required this.country,
    required this.region,
    required this.imageUrl,
    required this.collections,
    required this.openingHours,
    required this.contactInfo,
    required this.rating,
    required this.website,
    required this.isVirtualTourAvailable,
    required this.mediaGallery,
    this.panorama360Url,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        address,
        city,
        country,
        region,
        imageUrl,
        collections,
        openingHours,
        contactInfo,
        rating,
        website,
        isVirtualTourAvailable,
        mediaGallery,
        panorama360Url,
      ];
}