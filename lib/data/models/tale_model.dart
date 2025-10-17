import '../../domain/entities/tale.dart';

/// Data Transfer Object for Tale
class TaleModel extends Tale {
  const TaleModel({
    required super.id,
    required super.title,
    required super.content,
    required super.summary,
    required super.origin,
    required super.language,
    required super.category,
    required super.characters,
    required super.moralLesson,
    required super.narrator,
    required super.imageUrl,
    required super.duration,
    required super.ageGroup,
  });

  /// Create TaleModel from JSON
  factory TaleModel.fromJson(Map<String, dynamic> json) {
    return TaleModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      summary: json['summary'] as String? ?? '',
      origin: json['origin'] as String,
      language: json['language'] as String? ?? 'Unknown',
      category: json['category'] as String,
      characters: (json['characters'] as List<dynamic>?)?.cast<String>() ?? [],
      moralLesson: json['moral'] as String? ?? '',
      narrator: json['narrator'] as String? ?? 'Unknown',
      imageUrl: json['imageUrl'] as String? ?? '',
      duration: json['estimatedReadingTime'] as int? ?? 5,
      ageGroup: json['ageGroup'] as String? ?? 'All ages',
    );
  }

  /// Convert TaleModel to JSON
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
      'moral': moralLesson,
      'narrator': narrator,
      'imageUrl': imageUrl,
      'estimatedReadingTime': duration,
      'ageGroup': ageGroup,
    };
  }
}