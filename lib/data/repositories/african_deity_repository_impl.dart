import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/african_deity.dart';
import '../../domain/repositories/african_deity_repository.dart';
import '../datasources/local_data_source.dart';
import '../models/african_deity_model.dart';

class AfricanDeityRepositoryImpl implements AfricanDeityRepository {
  final LocalDataSource localDataSource;

  AfricanDeityRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<AfricanDeity>>> getAllDeities() async {
    try {
      final deitiesJson = await localDataSource.loadJsonData('assets/data/african_deities.json');
      final List<dynamic> deitiesList = deitiesJson as List<dynamic>;
      final deities = deitiesList
          .map((json) => AfricanDeityModel.fromJson(json as Map<String, dynamic>))
          .toList();
      return Right(deities);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load deities: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AfricanDeity>> getDeityById(String id) async {
    try {
      final result = await getAllDeities();
      return result.fold(
        (failure) => Left(failure),
        (deities) {
          try {
            final deity = deities.firstWhere((deity) => deity.id == id);
            return Right(deity);
          } catch (e) {
            return Left(CacheFailure(message: 'Deity with id $id not found'));
          }
        },
      );
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get deity: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<AfricanDeity>>> searchDeities(String query) async {
    try {
      final result = await getAllDeities();
      return result.fold(
        (failure) => Left(failure),
        (deities) {
          final filteredDeities = deities.where((deity) =>
              deity.name.toLowerCase().contains(query.toLowerCase()) ||
              deity.description.toLowerCase().contains(query.toLowerCase()) ||
              deity.domain.toLowerCase().contains(query.toLowerCase()) ||
              deity.origin.toLowerCase().contains(query.toLowerCase())).toList();
          return Right(filteredDeities);
        },
      );
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to search deities: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<AfricanDeity>>> getDeitiesByReligion(String religion) async {
    try {
      final result = await getAllDeities();
      return result.fold(
        (failure) => Left(failure),
        (deities) {
          final filteredDeities = deities.where((deity) =>
              deity.religion.toLowerCase().contains(religion.toLowerCase())).toList();
          return Right(filteredDeities);
        },
      );
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get deities by religion: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<AfricanDeity>>> getDeitiesByOrigin(String origin) async {
    try {
      final result = await getAllDeities();
      return result.fold(
        (failure) => Left(failure),
        (deities) {
          final filteredDeities = deities.where((deity) =>
              deity.origin.toLowerCase().contains(origin.toLowerCase())).toList();
          return Right(filteredDeities);
        },
      );
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get deities by origin: ${e.toString()}'));
    }
  }
}