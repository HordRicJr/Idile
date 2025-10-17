import 'package:dartz/dartz.dart';
import '../entities/african_music.dart';
import '../../core/error/failures.dart';

/// Abstract repository for African Music entities
abstract class AfricanMusicRepository {
  /// Get all music from data source
  Future<Either<Failure, List<AfricanMusic>>> getAllMusic();
  
  /// Get music by its unique identifier
  Future<Either<Failure, AfricanMusic>> getMusicById(String id);
  
  /// Get music filtered by genre
  Future<Either<Failure, List<AfricanMusic>>> getMusicByGenre(String genre);
  
  /// Get music filtered by origin (country/region)
  Future<Either<Failure, List<AfricanMusic>>> getMusicByOrigin(String origin);
  
  /// Search music by query (title, artist, description, origin)
  Future<Either<Failure, List<AfricanMusic>>> searchMusic(String query);
}