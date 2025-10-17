
import 'package:flutter/services.dart';
import '../../domain/entities/media_content.dart';

/// Service for loading and managing media content from JSON files
class MediaLoaderService {
  static const String _audioPath = 'assets/audio/';

  static const String _imagePath = 'assets/images/';

  /// Convert raw media URLs to MediaContent objects
  static List<MediaContent> processMediaUrls(
    List<dynamic> mediaUrls, 
    String contentId,
    String contentTitle
  ) {
    final List<MediaContent> mediaList = [];
    
    for (int i = 0; i < mediaUrls.length; i++) {
      final String url = mediaUrls[i].toString();
      final mediaContent = _createMediaContent(url, contentId, contentTitle, i);
      if (mediaContent != null) {
        mediaList.add(mediaContent);
      }
    }
    
    return mediaList;
  }

  /// Create MediaContent from URL
  static MediaContent? _createMediaContent(
    String url, 
    String contentId, 
    String contentTitle, 
    int index
  ) {
    // Determine media type from URL
    String type;
    String title;
    
    if (_isYouTubeUrl(url)) {
      type = 'youtube_video';
      title = 'Video: $contentTitle';
    } else if (_isAudioUrl(url)) {
      type = 'audio';
      title = 'Audio: $contentTitle';
    } else if (_isImageUrl(url)) {
      type = 'image';
      title = 'Image: $contentTitle';
    } else if (_isPanoramaUrl(url)) {
      type = 'panorama_360';
      title = '360° View: $contentTitle';
    } else {
      // Unknown type, skip
      return null;
    }

    return MediaContent(
      id: '${contentId}_media_$index',
      type: type,
      url: url,
      title: title,
      description: _generateDescription(type, contentTitle),
    );
  }

  /// Check if URL is a YouTube URL
  static bool _isYouTubeUrl(String url) {
    return url.contains('youtu.be') || 
           url.contains('youtube.com') ||
           url.contains('youtube');
  }

  /// Check if URL is an audio file
  static bool _isAudioUrl(String url) {
    return url.contains(_audioPath) || 
           url.endsWith('.mp3') || 
           url.endsWith('.wav') || 
           url.endsWith('.aac');
  }

  /// Check if URL is an image file
  static bool _isImageUrl(String url) {
    return url.contains(_imagePath) || 
           url.endsWith('.jpg') || 
           url.endsWith('.jpeg') || 
           url.endsWith('.png') || 
           url.endsWith('.webp');
  }

  /// Check if URL is a 360° panorama image
  static bool _isPanoramaUrl(String url) {
    return url.contains('360/') || 
           url.contains('panorama');
  }

  /// Generate appropriate description based on media type
  static String _generateDescription(String type, String contentTitle) {
    switch (type) {
      case 'youtube_video':
        return 'Educational video content about $contentTitle';
      case 'audio':
        return 'Audio content related to $contentTitle';
      case 'image':
        return 'Visual representation of $contentTitle';
      case 'panorama_360':
        return '360° immersive view of $contentTitle';
      default:
        return 'Media content for $contentTitle';
    }
  }

  /// Validate that audio file exists (for local assets)
  static Future<bool> validateAudioAsset(String assetPath) async {
    try {
      await rootBundle.load(assetPath);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Validate that image file exists (for local assets)
  static Future<bool> validateImageAsset(String assetPath) async {
    try {
      await rootBundle.load(assetPath);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Extract YouTube video ID from various URL formats
  static String? extractYouTubeId(String url) {
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
  static String getYouTubeThumbnail(String videoId) {
    return 'https://img.youtube.com/vi/$videoId/maxresdefault.jpg';
  }
}