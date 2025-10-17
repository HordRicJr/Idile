import 'package:dartz/dartz.dart';
import '../entities/quote.dart';
import '../../core/error/failures.dart';

/// Abstract repository for Quote entities
abstract class QuoteRepository {
  /// Get all quotes from data source
  Future<Either<Failure, List<Quote>>> getAllQuotes();
  
  /// Get quote by its unique identifier
  Future<Either<Failure, Quote>> getQuoteById(String id);
  
  /// Get quotes filtered by category
  Future<Either<Failure, List<Quote>>> getQuotesByCategory(String category);
  
  /// Get quotes filtered by author
  Future<Either<Failure, List<Quote>>> getQuotesByAuthor(String author);
  
  /// Search quotes by query (text, author, context)
  Future<Either<Failure, List<Quote>>> searchQuotes(String query);
}