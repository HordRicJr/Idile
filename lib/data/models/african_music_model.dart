import '../../domain/entities/african_music.dart';

/// Data Transfer Object for African Music
class AfricanMusicModel extends AfricanMusic {
  const AfricanMusicModel({
    required super.id,
    required super.title,
    required super.artist,
    required super.origin,
    required super.genre,
    required super.language,
    required super.description,
    required super.instruments,
    required super.culturalContext,
    required super.meaning,
    required super.audioUrl,
    required super.imageUrl,
    required super.duration,
    required super.period,
    required super.influence,
  });

  /// Create AfricanMusicModel from JSON
  factory AfricanMusicModel.fromJson(Map<String, dynamic> json) {
    return AfricanMusicModel(
      id: json['id'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String? ?? 'Unknown Artist',
      origin: json['origin'] as String,
      genre: json['genre'] as String? ?? 'Traditional',
      language: json['language'] as String? ?? 'Unknown',
      description: json['description'] as String? ?? '',
      instruments: (json['instruments'] as List<dynamic>?)?.cast<String>() ?? [],
      culturalContext: json['culturalContext'] as String? ?? json['context'] as String? ?? '',
      meaning: json['meaning'] as String? ?? json['significance'] as String? ?? '',
      audioUrl: json['audioUrl'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      duration: json['duration'] as int? ?? 0,
      period: json['period'] as String? ?? 'Traditional',
      influence: json['influence'] as String? ?? json['modernInfluence'] as String? ?? '',
    );
  }

  /// Convert AfricanMusicModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'origin': origin,
      'genre': genre,
      'language': language,
      'description': description,
      'instruments': instruments,
      'culturalContext': culturalContext,
      'meaning': meaning,
      'audioUrl': audioUrl,
      'imageUrl': imageUrl,
      'duration': duration,
      'period': period,
      'influence': influence,
    };
  }
}