import '../../domain/entities/quote.dart';

/// Data Transfer Object for Quote
class QuoteModel extends Quote {
  const QuoteModel({
    required super.id,
    required super.text,
    required super.author,
    required super.authorTitle,
    required super.context,
    required super.period,
    required super.language,
    required super.originalLanguage,
    required super.category,
    required super.source,
    required super.imageUrl,
  });

  /// Create QuoteModel from JSON
  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      id: json['id'] as String,
      text: json['text'] as String? ?? json['quote'] as String,
      author: json['author'] as String,
      authorTitle: json['authorTitle'] as String? ?? json['title'] as String? ?? '',
      context: json['context'] as String? ?? json['background'] as String? ?? '',
      period: json['period'] as String? ?? 'Historical',
      language: json['language'] as String? ?? 'French',
      originalLanguage: json['originalLanguage'] as String? ?? json['original'] as String? ?? 'Unknown',
      category: json['category'] as String? ?? json['type'] as String? ?? 'Wisdom',
      source: json['source'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  /// Convert QuoteModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'author': author,
      'authorTitle': authorTitle,
      'context': context,
      'period': period,
      'language': language,
      'originalLanguage': originalLanguage,
      'category': category,
      'source': source,
      'imageUrl': imageUrl,
    };
  }
}