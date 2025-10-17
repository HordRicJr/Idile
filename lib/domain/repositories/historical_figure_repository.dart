import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/historical_figure.dart';

/// Repository interface for historical figures
abstract class HistoricalFigureRepository {
  Future<Either<Failure, List<HistoricalFigure>>> getHistoricalFigures();
  Future<Either<Failure, List<HistoricalFigure>>> searchHistoricalFigures(String query);
  Future<Either<Failure, HistoricalFigure>> getHistoricalFigureById(String id);
  Future<Either<Failure, List<HistoricalFigure>>> getHistoricalFiguresByCategory(String category);
  Future<Either<Failure, List<HistoricalFigure>>> getHistoricalFiguresByRegion(String region);
}