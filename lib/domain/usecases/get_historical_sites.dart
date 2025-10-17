import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/historical_site.dart';
import '../repositories/historical_site_repository.dart';

class GetHistoricalSites {
  final HistoricalSiteRepository repository;

  GetHistoricalSites(this.repository);

  Future<Either<Failure, List<HistoricalSite>>> call() async {
    return await repository.getAllSites();
  }
}

class GetHistoricalSiteById {
  final HistoricalSiteRepository repository;

  GetHistoricalSiteById(this.repository);

  Future<Either<Failure, HistoricalSite>> call(String id) async {
    if (id.isEmpty) {
      return Left(ValidationFailure(message: 'L\'ID ne peut pas être vide'));
    }
    return await repository.getSiteById(id);
  }
}

class SearchHistoricalSites {
  final HistoricalSiteRepository repository;

  SearchHistoricalSites(this.repository);

  Future<Either<Failure, List<HistoricalSite>>> call(String query) async {
    if (query.isEmpty) {
      return Left(ValidationFailure(message: 'La requête de recherche ne peut pas être vide'));
    }
    return await repository.searchSites(query);
  }
}