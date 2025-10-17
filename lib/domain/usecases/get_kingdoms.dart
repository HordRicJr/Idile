import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/african_kingdom.dart';
import '../repositories/african_kingdom_repository.dart';

/// Use case for getting all kingdoms
class GetKingdoms {
  final AfricanKingdomRepository repository;

  const GetKingdoms(this.repository);

  Future<Either<Failure, List<AfricanKingdom>>> call() async {
    return await repository.getAllKingdoms();
  }
}

/// Use case for getting kingdom by ID
class GetKingdomById {
  final AfricanKingdomRepository repository;

  const GetKingdomById(this.repository);

  Future<Either<Failure, AfricanKingdom>> call(String id) async {
    return await repository.getKingdomById(id);
  }
}

/// Use case for searching kingdoms
class SearchKingdoms {
  final AfricanKingdomRepository repository;

  const SearchKingdoms(this.repository);

  Future<Either<Failure, List<AfricanKingdom>>> call(String query) async {
    return await repository.searchKingdoms(query);
  }
}

/// Use case for getting kingdoms by region
class GetKingdomsByRegion {
  final AfricanKingdomRepository repository;

  const GetKingdomsByRegion(this.repository);

  Future<Either<Failure, List<AfricanKingdom>>> call(String region) async {
    return await repository.getKingdomsByRegion(region);
  }
}