import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../datasources/local_data_source.dart';
import '../models/art_object_model.dart';
import '../../domain/entities/art_object.dart';
import '../../domain/repositories/art_object_repository.dart';

/// Implementation of ArtObjectRepository using local data source
class ArtObjectRepositoryImpl implements ArtObjectRepository {
  final LocalDataSource localDataSource;

  const ArtObjectRepositoryImpl({required this.localDataSource});

  Future<List<ArtObject>> _getAllArtObjects() async {
    final jsonList = await localDataSource.loadJsonData('assets/data/art_objects.json');
    return jsonList.map((json) => ArtObjectModel.fromJson(json)).toList();
  }

  @override
  Future<Either<Failure, List<ArtObject>>> getAllArtObjects() async {
    try {
      final artObjects = await _getAllArtObjects();
      return Right(artObjects);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load art objects: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, ArtObject>> getArtObjectById(String id) async {
    try {
      final artObjects = await _getAllArtObjects();
      final artObject = artObjects.firstWhere(
        (art) => art.id == id,
        orElse: () => throw Exception('Art object not found with id: $id'),
      );
      return Right(artObject);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get art object: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<ArtObject>>> getArtObjectsByCategory(String category) async {
    try {
      final artObjects = await _getAllArtObjects();
      final filteredObjects = artObjects.where((art) => 
        art.category.toLowerCase().contains(category.toLowerCase())).toList();
      return Right(filteredObjects);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load art objects by category: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<ArtObject>>> getArtObjectsByOrigin(String origin) async {
    try {
      final artObjects = await _getAllArtObjects();
      final filteredObjects = artObjects.where((art) => 
        art.origin.toLowerCase().contains(origin.toLowerCase())).toList();
      return Right(filteredObjects);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load art objects by origin: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<ArtObject>>> searchArtObjects(String query) async {
    try {
      final artObjects = await _getAllArtObjects();
      final lowerQuery = query.toLowerCase();
      final searchResults = artObjects.where((art) {
        return art.name.toLowerCase().contains(lowerQuery) ||
               art.description.toLowerCase().contains(lowerQuery) ||
               art.artist.toLowerCase().contains(lowerQuery) ||
               art.origin.toLowerCase().contains(lowerQuery);
      }).toList();
      return Right(searchResults);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to search art objects: ${e.toString()}'));
    }
  }
}