import 'package:dartz/dartz.dart';
import '../datasources/local_data_source.dart';
import '../models/african_kingdom_model.dart';
import '../../domain/entities/african_kingdom.dart';
import '../../domain/repositories/african_kingdom_repository.dart';
import '../../core/error/failures.dart';

/// Implementation of AfricanKingdomRepository using local data source
class AfricanKingdomRepositoryImpl implements AfricanKingdomRepository {
  final LocalDataSource localDataSource;

  const AfricanKingdomRepositoryImpl({required this.localDataSource});

  Future<List<AfricanKingdom>> _getAllKingdoms() async {
    final jsonList = await localDataSource.loadJsonData('assets/data/african_kingdoms.json');
    return jsonList.map((json) => AfricanKingdomModel.fromJson(json)).toList();
  }

  @override
  Future<Either<Failure, List<AfricanKingdom>>> getAllKingdoms() async {
    try {
      final kingdoms = await _getAllKingdoms();
      return Right(kingdoms);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load kingdoms: $e'));
    }
  }

  @override
  Future<Either<Failure, AfricanKingdom>> getKingdomById(String id) async {
    try {
      final kingdoms = await _getAllKingdoms();
      final kingdom = kingdoms.firstWhere(
        (kingdom) => kingdom.id == id,
        orElse: () => throw Exception('Kingdom not found with id: $id'),
      );
      return Right(kingdom);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get kingdom: $e'));
    }
  }

  @override
  Future<Either<Failure, List<AfricanKingdom>>> getKingdomsByRegion(String region) async {
    try {
      final kingdoms = await _getAllKingdoms();
      final filteredKingdoms = kingdoms.where((kingdom) => 
        kingdom.region.toLowerCase().contains(region.toLowerCase())).toList();
      return Right(filteredKingdoms);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load kingdoms by region: $e'));
    }
  }

  @override
  Future<Either<Failure, List<AfricanKingdom>>> searchKingdoms(String query) async {
    try {
      final kingdoms = await _getAllKingdoms();
      final lowerQuery = query.toLowerCase();
      final searchResults = kingdoms.where((kingdom) {
        return kingdom.name.toLowerCase().contains(lowerQuery) ||
               kingdom.description.toLowerCase().contains(lowerQuery) ||
               kingdom.region.toLowerCase().contains(lowerQuery);
      }).toList();
      return Right(searchResults);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to search kingdoms: $e'));
    }
  }
}