import 'package:equatable/equatable.dart';

/// Entity representing African traditional music
class AfricanMusic extends Equatable {
  final String id;
  final String title;
  final String artist;
  final String origin; // country/region
  final String genre; // traditional, contemporary, fusion
  final String language;
  final String description;
  final List<String> instruments; // instruments used
  final String culturalContext; // when/why it's performed
  final String meaning; // lyrical meaning or significance
  final String audioUrl;
  final String imageUrl;
  final int duration; // in seconds
  final String period; // historical period
  final String influence; // modern influence

  const AfricanMusic({
    required this.id,
    required this.title,
    required this.artist,
    required this.origin,
    required this.genre,
    required this.language,
    required this.description,
    required this.instruments,
    required this.culturalContext,
    required this.meaning,
    required this.audioUrl,
    required this.imageUrl,
    required this.duration,
    required this.period,
    required this.influence,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        artist,
        origin,
        genre,
        language,
        description,
        instruments,
        culturalContext,
        meaning,
        audioUrl,
        imageUrl,
        duration,
        period,
        influence,
      ];
}