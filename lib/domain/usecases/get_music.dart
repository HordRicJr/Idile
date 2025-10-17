import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/african_music.dart';
import '../repositories/african_music_repository.dart';

/// Use case for getting all music
class GetMusic {
  final AfricanMusicRepository repository;

  const GetMusic(this.repository);

  Future<Either<Failure, List<AfricanMusic>>> call() async {
    return await repository.getAllMusic();
  }
}

/// Use case for getting music by ID
class GetMusicById {
  final AfricanMusicRepository repository;

  const GetMusicById(this.repository);

  Future<Either<Failure, AfricanMusic>> call(String id) async {
    return await repository.getMusicById(id);
  }
}

/// Use case for searching music
class SearchMusic {
  final AfricanMusicRepository repository;

  const SearchMusic(this.repository);

  Future<Either<Failure, List<AfricanMusic>>> call(String query) async {
    return await repository.searchMusic(query);
  }
}

/// Use case for getting music by genre
class GetMusicByGenre {
  final AfricanMusicRepository repository;

  const GetMusicByGenre(this.repository);

  Future<Either<Failure, List<AfricanMusic>>> call(String genre) async {
    return await repository.getMusicByGenre(genre);
  }
}