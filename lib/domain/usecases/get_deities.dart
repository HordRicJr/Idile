import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/african_deity.dart';
import '../repositories/african_deity_repository.dart';

class GetDeities {
  final AfricanDeityRepository repository;

  GetDeities(this.repository);

  Future<Either<Failure, List<AfricanDeity>>> call() async {
    return await repository.getAllDeities();
  }
}

class GetDeityById {
  final AfricanDeityRepository repository;

  GetDeityById(this.repository);

  Future<Either<Failure, AfricanDeity>> call(String id) async {
    if (id.isEmpty) {
      return Left(ValidationFailure(message: 'L\'ID ne peut pas être vide'));
    }
    return await repository.getDeityById(id);
  }
}

class SearchDeities {
  final AfricanDeityRepository repository;

  SearchDeities(this.repository);

  Future<Either<Failure, List<AfricanDeity>>> call(String query) async {
    if (query.isEmpty) {
      return Left(ValidationFailure(message: 'La requête de recherche ne peut pas être vide'));
    }
    return await repository.searchDeities(query);
  }
}