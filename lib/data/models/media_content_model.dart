import '../../domain/entities/media_content.dart';

/// Data Transfer Object for MediaContent
class MediaContentModel extends MediaContent {
  const MediaContentModel({
    required super.id,
    required super.type,
    required super.url,
    super.thumbnailUrl,
    required super.title,
    super.description,
    super.duration,
    super.resolution,
    super.metadata,
  });

  /// Create MediaContentModel from JSON
  factory MediaContentModel.fromJson(Map<String, dynamic> json) {
    return MediaContentModel(
      id: json['id'] as String,
      type: json['type'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnail_url'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      duration: json['duration'] as int?,
      resolution: json['resolution'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  /// Convert MediaContentModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'url': url,
      'thumbnail_url': thumbnailUrl,
      'title': title,
      'description': description,
      'duration': duration,
      'resolution': resolution,
      'metadata': metadata,
    };
  }
}