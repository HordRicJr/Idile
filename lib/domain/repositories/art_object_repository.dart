import 'package:dartz/dartz.dart';
import '../entities/art_object.dart';
import '../../core/error/failures.dart';

/// Abstract repository for Art Object entities
abstract class ArtObjectRepository {
  /// Get all art objects from data source
  Future<Either<Failure, List<ArtObject>>> getAllArtObjects();
  
  /// Get art object by its unique identifier
  Future<Either<Failure, ArtObject>> getArtObjectById(String id);
  
  /// Get art objects filtered by category
  Future<Either<Failure, List<ArtObject>>> getArtObjectsByCategory(String category);
  
  /// Get art objects filtered by origin (country/region)
  Future<Either<Failure, List<ArtObject>>> getArtObjectsByOrigin(String origin);
  
  /// Search art objects by query (name, description, artist, origin)
  Future<Either<Failure, List<ArtObject>>> searchArtObjects(String query);
}