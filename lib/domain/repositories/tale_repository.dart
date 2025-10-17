import 'package:dartz/dartz.dart';
import '../entities/tale.dart';
import '../../core/error/failures.dart';

/// Abstract repository for Tale entities
abstract class TaleRepository {
  /// Get all tales from data source
  Future<Either<Failure, List<Tale>>> getAllTales();
  
  /// Get tale by its unique identifier
  Future<Either<Failure, Tale>> getTaleById(String id);
  
  /// Get tales filtered by category
  Future<Either<Failure, List<Tale>>> getTalesByCategory(String category);
  
  /// Get tales filtered by origin/region
  Future<Either<Failure, List<Tale>>> getTalesByOrigin(String origin);
  
  /// Search tales by query (title, content, origin, category)
  Future<Either<Failure, List<Tale>>> searchTales(String query);
}