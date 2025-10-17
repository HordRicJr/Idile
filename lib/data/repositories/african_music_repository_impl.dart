import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../datasources/local_data_source.dart';
import '../models/african_music_model.dart';
import '../../domain/entities/african_music.dart';
import '../../domain/repositories/african_music_repository.dart';

class AfricanMusicRepositoryImpl implements AfricanMusicRepository {
  final LocalDataSource localDataSource;

  AfricanMusicRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<AfricanMusic>>> getAllMusic() async {
    try {
      final musicJson = await localDataSource.loadJsonData('assets/data/african_music.json');
      final List<dynamic> musicList = musicJson as List<dynamic>;
      final music = musicList
          .map((json) => AfricanMusicModel.fromJson(json as Map<String, dynamic>))
          .toList();
      return Right(music);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load music: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AfricanMusic>> getMusicById(String id) async {
    try {
      final result = await getAllMusic();
      return result.fold(
        (failure) => Left(failure),
        (musicList) {
          try {
            final music = musicList.firstWhere((music) => music.id == id);
            return Right(music);
          } catch (e) {
            return Left(CacheFailure(message: 'African music with id $id not found'));
          }
        },
      );
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get music: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<AfricanMusic>>> getMusicByGenre(String genre) async {
    try {
      final result = await getAllMusic();
      return result.fold(
        (failure) => Left(failure),
        (musicList) {
          final filteredMusic = musicList.where((music) => 
            music.genre.toLowerCase().contains(genre.toLowerCase())).toList();
          return Right(filteredMusic);
        },
      );
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load music by genre: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<AfricanMusic>>> getMusicByOrigin(String origin) async {
    try {
      final result = await getAllMusic();
      return result.fold(
        (failure) => Left(failure),
        (musicList) {
          final filteredMusic = musicList.where((music) => 
            music.origin.toLowerCase().contains(origin.toLowerCase())).toList();
          return Right(filteredMusic);
        },
      );
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load music by origin: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<AfricanMusic>>> searchMusic(String query) async {
    try {
      final result = await getAllMusic();
      return result.fold(
        (failure) => Left(failure),
        (musicList) {
          final filteredMusic = musicList.where((music) =>
              music.title.toLowerCase().contains(query.toLowerCase()) ||
              music.description.toLowerCase().contains(query.toLowerCase()) ||
              music.genre.toLowerCase().contains(query.toLowerCase()) ||
              music.origin.toLowerCase().contains(query.toLowerCase())).toList();
          return Right(filteredMusic);
        },
      );
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to search music: ${e.toString()}'));
    }
  }
}