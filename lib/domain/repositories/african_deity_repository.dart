import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/african_deity.dart';

abstract class AfricanDeityRepository {
  Future<Either<Failure, List<AfricanDeity>>> getAllDeities();
  Future<Either<Failure, AfricanDeity>> getDeityById(String id);
  Future<Either<Failure, List<AfricanDeity>>> searchDeities(String query);
  Future<Either<Failure, List<AfricanDeity>>> getDeitiesByReligion(String religion);
  Future<Either<Failure, List<AfricanDeity>>> getDeitiesByOrigin(String origin);
}