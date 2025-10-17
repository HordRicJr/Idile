import 'package:dartz/dartz.dart';
import '../entities/african_festival.dart';
import '../../core/error/failures.dart';

/// Abstract repository for African Festival entities
abstract class AfricanFestivalRepository {
  /// Get all festivals from data source
  Future<Either<Failure, List<AfricanFestival>>> getAllFestivals();
  
  /// Get festival by its unique identifier
  Future<Either<Failure, AfricanFestival>> getFestivalById(String id);
  
  /// Get festivals filtered by origin (country/region)
  Future<Either<Failure, List<AfricanFestival>>> getFestivalsByOrigin(String origin);
  
  /// Get festivals filtered by period/season
  Future<Either<Failure, List<AfricanFestival>>> getFestivalsByPeriod(String period);
  
  /// Search festivals by query (name, description, origin)
  Future<Either<Failure, List<AfricanFestival>>> searchFestivals(String query);
}