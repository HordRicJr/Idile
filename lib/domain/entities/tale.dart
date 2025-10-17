import 'package:equatable/equatable.dart';

/// Entity representing an African tale/story
class Tale extends Equatable {
  final String id;
  final String title;
  final String content;
  final String summary;
  final String origin; // country/region of origin
  final String language;
  final String category; // moral tale, legend, myth, etc.
  final List<String> characters;
  final String moralLesson;
  final String narrator;
  final String imageUrl;
  final int duration; // estimated reading time in minutes
  final String ageGroup; // children, adults, all ages

  const Tale({
    required this.id,
    required this.title,
    required this.content,
    required this.summary,
    required this.origin,
    required this.language,
    required this.category,
    required this.characters,
    required this.moralLesson,
    required this.narrator,
    required this.imageUrl,
    required this.duration,
    required this.ageGroup,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        summary,
        origin,
        language,
        category,
        characters,
        moralLesson,
        narrator,
        imageUrl,
        duration,
        ageGroup,
      ];

  factory Tale.fromJson(Map<String, dynamic> json) {
    return Tale(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      summary: json['summary'] ?? '',
      origin: json['origin'] ?? '',
      language: json['language'] ?? '',
      category: json['category'] ?? '',
      characters: List<String>.from(json['characters'] ?? []),
      moralLesson: json['moralLesson'] ?? '',
      narrator: json['narrator'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      duration: json['duration'] ?? 0,
      ageGroup: json['ageGroup'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'summary': summary,
      'origin': origin,
      'language': language,
      'category': category,
      'characters': characters,
      'moralLesson': moralLesson,
      'narrator': narrator,
      'imageUrl': imageUrl,
      'duration': duration,
      'ageGroup': ageGroup,
    };
  }
}