import 'package:dartz/dartz.dart';
import '../entities/tale.dart';
import '../repositories/tale_repository.dart';
import '../../core/error/failures.dart';

/// Use case pour rechercher des contes
class SearchTales {
  final TaleRepository repository;

  SearchTales(this.repository);

  Future<Either<Failure, List<Tale>>> call(String query) async {
    if (query.isEmpty) {
      return Left(ValidationFailure(message: 'La requête de recherche ne peut pas être vide'));
    }
    return await repository.searchTales(query);
  }
}