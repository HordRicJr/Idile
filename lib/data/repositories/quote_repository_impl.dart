import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../datasources/local_data_source.dart';
import '../models/quote_model.dart';
import '../../domain/entities/quote.dart';
import '../../domain/repositories/quote_repository.dart';

/// Implementation of QuoteRepository using local data source
class QuoteRepositoryImpl implements QuoteRepository {
  final LocalDataSource localDataSource;

  const QuoteRepositoryImpl({required this.localDataSource});

  Future<List<Quote>> _getAllQuotes() async {
    final jsonList = await localDataSource.loadJsonData('assets/data/quotes.json');
    return jsonList.map((json) => QuoteModel.fromJson(json)).toList();
  }

  @override
  Future<Either<Failure, List<Quote>>> getAllQuotes() async {
    try {
      final quotes = await _getAllQuotes();
      return Right(quotes);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load quotes: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Quote>> getQuoteById(String id) async {
    try {
      final quotes = await _getAllQuotes();
      final quote = quotes.firstWhere(
        (quote) => quote.id == id,
        orElse: () => throw Exception('Quote not found with id: $id'),
      );
      return Right(quote);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get quote: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Quote>>> getQuotesByCategory(String category) async {
    try {
      final quotes = await _getAllQuotes();
      final filteredQuotes = quotes.where((quote) => 
        quote.category.toLowerCase().contains(category.toLowerCase())).toList();
      return Right(filteredQuotes);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load quotes by category: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Quote>>> getQuotesByAuthor(String author) async {
    try {
      final quotes = await _getAllQuotes();
      final filteredQuotes = quotes.where((quote) => 
        quote.author.toLowerCase().contains(author.toLowerCase())).toList();
      return Right(filteredQuotes);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load quotes by author: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Quote>>> searchQuotes(String query) async {
    try {
      final quotes = await _getAllQuotes();
      final lowerQuery = query.toLowerCase();
      final searchResults = quotes.where((quote) {
        return quote.text.toLowerCase().contains(lowerQuery) ||
               quote.author.toLowerCase().contains(lowerQuery) ||
               quote.context.toLowerCase().contains(lowerQuery);
      }).toList();
      return Right(searchResults);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to search quotes: ${e.toString()}'));
    }
  }
}