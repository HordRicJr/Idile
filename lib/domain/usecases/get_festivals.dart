import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/african_festival.dart';
import '../repositories/african_festival_repository.dart';

/// Use case for getting all festivals
class GetFestivals {
  final AfricanFestivalRepository repository;

  const GetFestivals(this.repository);

  Future<Either<Failure, List<AfricanFestival>>> call() async {
    return await repository.getAllFestivals();
  }
}

/// Use case for getting festival by ID
class GetFestivalById {
  final AfricanFestivalRepository repository;

  const GetFestivalById(this.repository);

  Future<Either<Failure, AfricanFestival>> call(String id) async {
    return await repository.getFestivalById(id);
  }
}

/// Use case for searching festivals
class SearchFestivals {
  final AfricanFestivalRepository repository;

  const SearchFestivals(this.repository);

  Future<Either<Failure, List<AfricanFestival>>> call(String query) async {
    return await repository.searchFestivals(query);
  }
}

/// Use case for getting festivals by origin
class GetFestivalsByOrigin {
  final AfricanFestivalRepository repository;

  const GetFestivalsByOrigin(this.repository);

  Future<Either<Failure, List<AfricanFestival>>> call(String origin) async {
    return await repository.getFestivalsByOrigin(origin);
  }
}