import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/museum.dart';

abstract class MuseumRepository {
  Future<Either<Failure, List<Museum>>> getAllMuseums();
  Future<Either<Failure, Museum>> getMuseumById(String id);
  Future<Either<Failure, List<Museum>>> searchMuseums(String query);
  Future<Either<Failure, List<Museum>>> getMuseumsByCountry(String country);
  Future<Either<Failure, List<Museum>>> getMuseumsByCity(String city);
  Future<Either<Failure, List<Museum>>> getMuseumsWithVirtualTours();
}