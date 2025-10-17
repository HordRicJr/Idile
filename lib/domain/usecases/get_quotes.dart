import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/quote.dart';
import '../repositories/quote_repository.dart';

/// Use case for getting all quotes
class GetQuotes {
  final QuoteRepository repository;

  const GetQuotes(this.repository);

  Future<Either<Failure, List<Quote>>> call() async {
    return await repository.getAllQuotes();
  }
}

/// Use case for getting quote by ID
class GetQuoteById {
  final QuoteRepository repository;

  const GetQuoteById(this.repository);

  Future<Either<Failure, Quote>> call(String id) async {
    return await repository.getQuoteById(id);
  }
}

/// Use case for searching quotes
class SearchQuotes {
  final QuoteRepository repository;

  const SearchQuotes(this.repository);

  Future<Either<Failure, List<Quote>>> call(String query) async {
    return await repository.searchQuotes(query);
  }
}

/// Use case for getting quotes by author
class GetQuotesByAuthor {
  final QuoteRepository repository;

  const GetQuotesByAuthor(this.repository);

  Future<Either<Failure, List<Quote>>> call(String author) async {
    return await repository.getQuotesByAuthor(author);
  }
}