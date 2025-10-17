import 'package:equatable/equatable.dart';

/// Entity representing an African historical quote
class Quote extends Equatable {
  final String id;
  final String text;
  final String author;
  final String authorTitle;
  final String context;
  final String period;
  final String language;
  final String originalLanguage;
  final String category; // wisdom, politics, philosophy, etc.
  final String source;
  final String imageUrl;

  const Quote({
    required this.id,
    required this.text,
    required this.author,
    required this.authorTitle,
    required this.context,
    required this.period,
    required this.language,
    required this.originalLanguage,
    required this.category,
    required this.source,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        text,
        author,
        authorTitle,
        context,
        period,
        language,
        originalLanguage,
        category,
        source,
        imageUrl,
      ];
}