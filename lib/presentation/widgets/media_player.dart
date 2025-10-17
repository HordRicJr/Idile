import 'package:flutter/material.dart';
import '../../domain/entities/media_content.dart';
import 'youtube_player.dart';

/// Widget for playing different types of media content
class MediaPlayer extends StatelessWidget {
  final MediaContent mediaContent;
  final bool autoPlay;
  final bool showControls;

  const MediaPlayer({
    Key? key,
    required this.mediaContent,
    this.autoPlay = false,
    this.showControls = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Route to appropriate player based on media type
    if (mediaContent.isYouTubeVideo) {
      return YouTubeVideoPlayer(
        mediaContent: mediaContent,
        autoPlay: autoPlay,
        showControls: showControls,
      );
    } else if (mediaContent.isAudio) {
      return AudioPlayerWidget(
        mediaContent: mediaContent,
        autoPlay: autoPlay,
        showControls: showControls,
      );
    } else if (mediaContent.isImage) {
      return ImageViewer(mediaContent: mediaContent);
    } else {
      return _buildUnsupportedMedia();
    }
  }

  Widget _buildUnsupportedMedia() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 32,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 8),
            Text(
              'Unsupported media type: ${mediaContent.type}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Audio Player Widget (placeholder - implement if needed)
class AudioPlayerWidget extends StatelessWidget {
  final MediaContent mediaContent;
  final bool autoPlay;
  final bool showControls;

  const AudioPlayerWidget({
    Key? key,
    required this.mediaContent,
    this.autoPlay = false,
    this.showControls = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.audiotrack,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  mediaContent.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (mediaContent.description != null) ...[
            const SizedBox(height: 4),
            Text(
              mediaContent.description!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: Colors.blue,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Audio player will be implemented in future updates',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue[600],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Simple Image Viewer
class ImageViewer extends StatelessWidget {
  final MediaContent mediaContent;

  const ImageViewer({
    Key? key,
    required this.mediaContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        mediaContent.url,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Failed to load image',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}