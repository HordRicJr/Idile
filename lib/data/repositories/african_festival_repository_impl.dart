import 'package:dartz/dartz.dart';
import '../datasources/local_data_source.dart';
import '../models/african_festival_model.dart';
import '../../domain/entities/african_festival.dart';
import '../../domain/repositories/african_festival_repository.dart';
import '../../core/error/failures.dart';

/// Implementation of AfricanFestivalRepository using local data source
class AfricanFestivalRepositoryImpl implements AfricanFestivalRepository {
  final LocalDataSource localDataSource;

  const AfricanFestivalRepositoryImpl({required this.localDataSource});

  Future<List<AfricanFestival>> _getAllFestivals() async {
    final jsonList = await localDataSource.loadJsonData('assets/data/african_festivals.json');
    return jsonList.map((json) => AfricanFestivalModel.fromJson(json)).toList();
  }

  @override
  Future<Either<Failure, List<AfricanFestival>>> getAllFestivals() async {
    try {
      final festivals = await _getAllFestivals();
      return Right(festivals);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load festivals: $e'));
    }
  }

  @override
  Future<Either<Failure, AfricanFestival>> getFestivalById(String id) async {
    try {
      final festivals = await _getAllFestivals();
      final festival = festivals.firstWhere(
        (festival) => festival.id == id,
        orElse: () => throw Exception('Festival not found with id: $id'),
      );
      return Right(festival);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get festival: $e'));
    }
  }

  @override
  Future<Either<Failure, List<AfricanFestival>>> getFestivalsByOrigin(String origin) async {
    try {
      final festivals = await _getAllFestivals();
      final filteredFestivals = festivals.where((festival) => 
        festival.origin.toLowerCase().contains(origin.toLowerCase())).toList();
      return Right(filteredFestivals);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load festivals by origin: $e'));
    }
  }

  @override
  Future<Either<Failure, List<AfricanFestival>>> getFestivalsByPeriod(String period) async {
    try {
      final festivals = await _getAllFestivals();
      final filteredFestivals = festivals.where((festival) => 
        festival.period.toLowerCase().contains(period.toLowerCase())).toList();
      return Right(filteredFestivals);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load festivals by period: $e'));
    }
  }

  @override
  Future<Either<Failure, List<AfricanFestival>>> searchFestivals(String query) async {
    try {
      final festivals = await _getAllFestivals();
      final lowerQuery = query.toLowerCase();
      final searchResults = festivals.where((festival) {
        return festival.name.toLowerCase().contains(lowerQuery) ||
               festival.description.toLowerCase().contains(lowerQuery) ||
               festival.origin.toLowerCase().contains(lowerQuery);
      }).toList();
      return Right(searchResults);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to search festivals: $e'));
    }
  }
}