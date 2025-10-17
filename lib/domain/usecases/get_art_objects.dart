import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/art_object.dart';
import '../repositories/art_object_repository.dart';

/// Use case for getting all art objects
class GetArtObjects {
  final ArtObjectRepository repository;

  const GetArtObjects(this.repository);

  Future<Either<Failure, List<ArtObject>>> call() async {
    return await repository.getAllArtObjects();
  }
}

/// Use case for getting art object by ID
class GetArtObjectById {
  final ArtObjectRepository repository;

  const GetArtObjectById(this.repository);

  Future<Either<Failure, ArtObject>> call(String id) async {
    return await repository.getArtObjectById(id);
  }
}

/// Use case for searching art objects
class SearchArtObjects {
  final ArtObjectRepository repository;

  const SearchArtObjects(this.repository);

  Future<Either<Failure, List<ArtObject>>> call(String query) async {
    return await repository.searchArtObjects(query);
  }
}

/// Use case for getting art objects by category
class GetArtObjectsByCategory {
  final ArtObjectRepository repository;

  const GetArtObjectsByCategory(this.repository);

  Future<Either<Failure, List<ArtObject>>> call(String category) async {
    return await repository.getArtObjectsByCategory(category);
  }
}