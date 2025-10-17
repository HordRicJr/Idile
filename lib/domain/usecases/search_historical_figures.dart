import 'package:dartz/dartz.dart';
import '../entities/historical_figure.dart';
import '../repositories/historical_figure_repository.dart';
import '../../core/error/failures.dart';

/// Use case pour rechercher des personnages historiques
class SearchHistoricalFigures {
  final HistoricalFigureRepository repository;

  SearchHistoricalFigures(this.repository);

  Future<Either<Failure, List<HistoricalFigure>>> call(String query) async {
    if (query.isEmpty) {
      return Left(ValidationFailure(message: 'La requête de recherche ne peut pas être vide'));
    }
    return await repository.searchHistoricalFigures(query);
  }
}