import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/historical_site.dart';

abstract class HistoricalSiteRepository {
  Future<Either<Failure, List<HistoricalSite>>> getAllSites();
  Future<Either<Failure, HistoricalSite>> getSiteById(String id);
  Future<Either<Failure, List<HistoricalSite>>> searchSites(String query);
  Future<Either<Failure, List<HistoricalSite>>> getSitesByCountry(String country);
  Future<Either<Failure, List<HistoricalSite>>> getSitesByCategory(String category);
  Future<Either<Failure, List<HistoricalSite>>> getUnescoSites();
}