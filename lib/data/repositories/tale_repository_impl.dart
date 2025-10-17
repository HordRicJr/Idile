import 'package:dartz/dartz.dart';
import '../datasources/local_data_source.dart';
import '../models/tale_model.dart';
import '../../domain/entities/tale.dart';
import '../../domain/repositories/tale_repository.dart';
import '../../core/error/failures.dart';

/// Implementation of TaleRepository using local data source
class TaleRepositoryImpl implements TaleRepository {
  final LocalDataSource localDataSource;

  const TaleRepositoryImpl({required this.localDataSource});

  Future<List<Tale>> _getAllTales() async {
    final jsonList = await localDataSource.loadJsonData('assets/data/tales.json');
    return jsonList.map((json) => TaleModel.fromJson(json)).toList();
  }

  @override
  Future<Either<Failure, List<Tale>>> getAllTales() async {
    try {
      final tales = await _getAllTales();
      return Right(tales);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load tales: $e'));
    }
  }

  @override
  Future<Either<Failure, Tale>> getTaleById(String id) async {
    try {
      final tales = await _getAllTales();
      final tale = tales.firstWhere(
        (tale) => tale.id == id,
        orElse: () => throw Exception('Tale not found with id: $id'),
      );
      return Right(tale);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get tale: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Tale>>> getTalesByCategory(String category) async {
    try {
      final tales = await _getAllTales();
      final filteredTales = tales.where((tale) => 
        tale.category.toLowerCase().contains(category.toLowerCase())).toList();
      return Right(filteredTales);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load tales by category: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Tale>>> getTalesByOrigin(String origin) async {
    try {
      final tales = await _getAllTales();
      final filteredTales = tales.where((tale) => 
        tale.origin.toLowerCase().contains(origin.toLowerCase())).toList();
      return Right(filteredTales);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load tales by origin: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Tale>>> searchTales(String query) async {
    try {
      final tales = await _getAllTales();
      final lowerQuery = query.toLowerCase();
      final searchResults = tales.where((tale) {
        return tale.title.toLowerCase().contains(lowerQuery) ||
               tale.content.toLowerCase().contains(lowerQuery) ||
               tale.origin.toLowerCase().contains(lowerQuery) ||
               tale.category.toLowerCase().contains(lowerQuery);
      }).toList();
      return Right(searchResults);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to search tales: $e'));
    }
  }
}