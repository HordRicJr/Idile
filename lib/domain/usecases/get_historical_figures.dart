import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/historical_figure.dart';
import '../repositories/historical_figure_repository.dart';

/// Use case to retrieve all historical figures
class GetHistoricalFigures {
  final HistoricalFigureRepository repository;

  GetHistoricalFigures(this.repository);

  Future<Either<Failure, List<HistoricalFigure>>> call() async {
    return await repository.getHistoricalFigures();
  }
}