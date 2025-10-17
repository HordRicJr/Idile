import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/historical_site.dart';
import '../../domain/repositories/historical_site_repository.dart';
import '../datasources/local_data_source.dart';
import '../models/historical_site_model.dart';

class HistoricalSiteRepositoryImpl implements HistoricalSiteRepository {
  final LocalDataSource localDataSource;

  HistoricalSiteRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<HistoricalSite>>> getAllSites() async {
    try {
      final sitesJson = await localDataSource.loadJsonData('assets/data/historical_sites.json');
      final List<dynamic> sitesList = sitesJson as List<dynamic>;
      final sites = sitesList
          .map((json) => HistoricalSiteModel.fromJson(json as Map<String, dynamic>))
          .toList();
      return Right(sites);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load historical sites: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, HistoricalSite>> getSiteById(String id) async {
    try {
      final result = await getAllSites();
      return result.fold(
        (failure) => Left(failure),
        (sites) {
          try {
            final site = sites.firstWhere((site) => site.id == id);
            return Right(site);
          } catch (e) {
            return Left(CacheFailure(message: 'Historical site with id $id not found'));
          }
        },
      );
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get historical site: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<HistoricalSite>>> searchSites(String query) async {
    try {
      final result = await getAllSites();
      return result.fold(
        (failure) => Left(failure),
        (sites) {
          final filteredSites = sites.where((site) =>
              site.name.toLowerCase().contains(query.toLowerCase()) ||
              site.description.toLowerCase().contains(query.toLowerCase()) ||
              site.location.toLowerCase().contains(query.toLowerCase()) ||
              site.country.toLowerCase().contains(query.toLowerCase())).toList();
          return Right(filteredSites);
        },
      );
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to search historical sites: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<HistoricalSite>>> getSitesByCountry(String country) async {
    try {
      final result = await getAllSites();
      return result.fold(
        (failure) => Left(failure),
        (sites) {
          final filteredSites = sites.where((site) =>
              site.country.toLowerCase().contains(country.toLowerCase())).toList();
          return Right(filteredSites);
        },
      );
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get sites by country: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<HistoricalSite>>> getSitesByCategory(String category) async {
    try {
      final result = await getAllSites();
      return result.fold(
        (failure) => Left(failure),
        (sites) {
          final filteredSites = sites.where((site) =>
              site.category.toLowerCase().contains(category.toLowerCase())).toList();
          return Right(filteredSites);
        },
      );
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get sites by category: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<HistoricalSite>>> getUnescoSites() async {
    try {
      final result = await getAllSites();
      return result.fold(
        (failure) => Left(failure),
        (sites) {
          final unescoSites = sites.where((site) => site.isUnescoSite).toList();
          return Right(unescoSites);
        },
      );
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get UNESCO sites: ${e.toString()}'));
    }
  }
}