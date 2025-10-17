import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/museum.dart';
import '../../domain/repositories/museum_repository.dart';
import '../datasources/local_data_source.dart';
import '../models/museum_model.dart';

class MuseumRepositoryImpl implements MuseumRepository {
  final LocalDataSource localDataSource;

  MuseumRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Museum>>> getAllMuseums() async {
    try {
      final museumsJson = await localDataSource.loadJsonData('assets/data/museums.json');
      final List<dynamic> museumsList = museumsJson as List<dynamic>;
      final museums = museumsList
          .map((json) => MuseumModel.fromJson(json as Map<String, dynamic>))
          .toList();
      return Right(museums);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load museums: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Museum>> getMuseumById(String id) async {
    try {
      final result = await getAllMuseums();
      return result.fold(
        (failure) => Left(failure),
        (museums) {
          try {
            final museum = museums.firstWhere((museum) => museum.id == id);
            return Right(museum);
          } catch (e) {
            return Left(CacheFailure(message: 'Museum with id $id not found'));
          }
        },
      );
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get museum: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Museum>>> searchMuseums(String query) async {
    try {
      final result = await getAllMuseums();
      return result.fold(
        (failure) => Left(failure),
        (museums) {
          final filteredMuseums = museums.where((museum) =>
              museum.name.toLowerCase().contains(query.toLowerCase()) ||
              museum.description.toLowerCase().contains(query.toLowerCase()) ||
              museum.city.toLowerCase().contains(query.toLowerCase()) ||
              museum.country.toLowerCase().contains(query.toLowerCase())).toList();
          return Right(filteredMuseums);
        },
      );
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to search museums: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Museum>>> getMuseumsByCountry(String country) async {
    try {
      final result = await getAllMuseums();
      return result.fold(
        (failure) => Left(failure),
        (museums) {
          final filteredMuseums = museums.where((museum) =>
              museum.country.toLowerCase().contains(country.toLowerCase())).toList();
          return Right(filteredMuseums);
        },
      );
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get museums by country: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Museum>>> getMuseumsByCity(String city) async {
    try {
      final result = await getAllMuseums();
      return result.fold(
        (failure) => Left(failure),
        (museums) {
          final filteredMuseums = museums.where((museum) =>
              museum.city.toLowerCase().contains(city.toLowerCase())).toList();
          return Right(filteredMuseums);
        },
      );
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get museums by city: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Museum>>> getMuseumsWithVirtualTours() async {
    try {
      final result = await getAllMuseums();
      return result.fold(
        (failure) => Left(failure),
        (museums) {
          final virtualTourMuseums = museums.where((museum) => museum.isVirtualTourAvailable).toList();
          return Right(virtualTourMuseums);
        },
      );
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get museums with virtual tours: ${e.toString()}'));
    }
  }
}