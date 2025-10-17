import 'package:dartz/dartz.dart';
import '../datasources/local_data_source.dart';
import '../models/historical_figure_model.dart';
import '../../domain/entities/historical_figure.dart';
import '../../domain/repositories/historical_figure_repository.dart';
import '../../core/error/failures.dart';

/// Implementation of HistoricalFigureRepository using local data source  
class HistoricalFigureRepositoryImpl implements HistoricalFigureRepository {
  final LocalDataSource localDataSource;

  const HistoricalFigureRepositoryImpl({required this.localDataSource});

  Future<List<HistoricalFigure>> _getAllHistoricalFigures() async {
    final jsonList = await localDataSource.loadJsonData('assets/data/historical_figures.json');
    return jsonList.map((json) => HistoricalFigureModel.fromJson(json)).toList();
  }

  @override
  Future<Either<Failure, List<HistoricalFigure>>> getHistoricalFigures() async {
    try {
      final figures = await _getAllHistoricalFigures();
      return Right(figures);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load historical figures: $e'));
    }
  }

  @override
  Future<Either<Failure, HistoricalFigure>> getHistoricalFigureById(String id) async {
    try {
      final figures = await _getAllHistoricalFigures();
      final figure = figures.firstWhere(
        (figure) => figure.id == id,
        orElse: () => throw Exception('Historical figure not found with id: $id'),
      );
      return Right(figure);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get historical figure: $e'));
    }
  }

  @override
  Future<Either<Failure, List<HistoricalFigure>>> getHistoricalFiguresByRegion(String region) async {
    try {
      final figures = await _getAllHistoricalFigures();
      final filteredFigures = figures.where((figure) => 
        figure.region.toLowerCase().contains(region.toLowerCase())).toList();
      return Right(filteredFigures);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load historical figures by region: $e'));
    }
  }

  @override
  Future<Either<Failure, List<HistoricalFigure>>> getHistoricalFiguresByCategory(String category) async {
    try {
      final figures = await _getAllHistoricalFigures();
      final filteredFigures = figures.where((figure) => 
        figure.category.toLowerCase().contains(category.toLowerCase())).toList();
      return Right(filteredFigures);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load historical figures by category: $e'));
    }
  }

  @override
  Future<Either<Failure, List<HistoricalFigure>>> searchHistoricalFigures(String query) async {
    try {
      final figures = await _getAllHistoricalFigures();
      final lowerQuery = query.toLowerCase();
      final searchResults = figures.where((figure) {
        return figure.name.toLowerCase().contains(lowerQuery) ||
               figure.biography.toLowerCase().contains(lowerQuery) ||
               figure.region.toLowerCase().contains(lowerQuery) ||
               figure.period.toLowerCase().contains(lowerQuery);
      }).toList();
      return Right(searchResults);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to search historical figures: $e'));
    }
  }
}