import 'package:dartz/dartz.dart';
import '../entities/african_kingdom.dart';
import '../../core/error/failures.dart';

/// Abstract repository for African Kingdom entities
abstract class AfricanKingdomRepository {
  /// Get all kingdoms from data source
  Future<Either<Failure, List<AfricanKingdom>>> getAllKingdoms();
  
  /// Get kingdom by its unique identifier
  Future<Either<Failure, AfricanKingdom>> getKingdomById(String id);
  
  /// Get kingdoms filtered by region
  Future<Either<Failure, List<AfricanKingdom>>> getKingdomsByRegion(String region);
  
  /// Search kingdoms by query (name, description, region)
  Future<Either<Failure, List<AfricanKingdom>>> searchKingdoms(String query);
}