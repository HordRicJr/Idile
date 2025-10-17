import 'package:equatable/equatable.dart';

/// Entity representing different types of media content
class MediaContent extends Equatable {
  final String id;
  final String type; // image, youtube_video, audio, panorama_360
  final String url; // for YouTube: video ID or full URL
  final String? thumbnailUrl;
  final String title;
  final String? description;
  final int? duration; // for audio/video in seconds
  final String? resolution; // for images/videos
  final Map<String, dynamic>? metadata; // additional properties

  const MediaContent({
    required this.id,
    required this.type,
    required this.url,
    this.thumbnailUrl,
    required this.title,
    this.description,
    this.duration,
    this.resolution,
    this.metadata,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        url,
        thumbnailUrl,
        title,
        description,
        duration,
        resolution,
        metadata,
      ];

  /// Check if this media is a 360° panorama
  bool get isPanorama => type == 'panorama_360';

  /// Check if this media is a YouTube video
  bool get isYouTubeVideo => type == 'youtube_video';

  /// Check if this media is audio
  bool get isAudio => type == 'audio';

  /// Check if this media is a regular image
  bool get isImage => type == 'image';

  /// Extract YouTube video ID from URL
  String? get youTubeVideoId {
    if (!isYouTubeVideo) return null;
    
    // If it's already just an ID (11 characters)
    if (url.length == 11 && !url.contains('/') && !url.contains('=')) {
      return url;
    }
    
    // Extract from various YouTube URL formats
    final regExp = RegExp(
      r'(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/)([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
      multiLine: false,
    );
    
    final match = regExp.firstMatch(url);
    return match?.group(1);
  }

  /// Get YouTube thumbnail URL
  String get youTubeThumbnail {
    if (!isYouTubeVideo || youTubeVideoId == null) {
      return thumbnailUrl ?? 'assets/images/placeholder.png';
    }
    return 'https://img.youtube.com/vi/$youTubeVideoId/maxresdefault.jpg';
  }
}