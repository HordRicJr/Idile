import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/museum.dart';
import '../repositories/museum_repository.dart';

class GetMuseums {
  final MuseumRepository repository;

  GetMuseums(this.repository);

  Future<Either<Failure, List<Museum>>> call() async {
    return await repository.getAllMuseums();
  }
}

class GetMuseumById {
  final MuseumRepository repository;

  GetMuseumById(this.repository);

  Future<Either<Failure, Museum>> call(String id) async {
    if (id.isEmpty) {
      return Left(ValidationFailure(message: 'L\'ID ne peut pas être vide'));
    }
    return await repository.getMuseumById(id);
  }
}

class SearchMuseums {
  final MuseumRepository repository;

  SearchMuseums(this.repository);

  Future<Either<Failure, List<Museum>>> call(String query) async {
    if (query.isEmpty) {
      return Left(ValidationFailure(message: 'La requête de recherche ne peut pas être vide'));
    }
    return await repository.searchMuseums(query);
  }
}