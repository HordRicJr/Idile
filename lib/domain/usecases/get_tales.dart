import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/tale.dart';
import '../repositories/tale_repository.dart';

/// Use case for getting all tales
class GetTales {
  final TaleRepository repository;

  const GetTales(this.repository);

  Future<Either<Failure, List<Tale>>> call() async {
    return await repository.getAllTales();
  }
}

/// Use case for getting tale by ID
class GetTaleById {
  final TaleRepository repository;

  const GetTaleById(this.repository);

  Future<Either<Failure, Tale>> call(String id) async {
    return await repository.getTaleById(id);
  }
}

/// Use case for searching tales
class SearchTales {
  final TaleRepository repository;

  const SearchTales(this.repository);

  Future<Either<Failure, List<Tale>>> call(String query) async {
    return await repository.searchTales(query);
  }
}

/// Use case for getting tales by category
class GetTalesByCategory {
  final TaleRepository repository;

  const GetTalesByCategory(this.repository);

  Future<Either<Failure, List<Tale>>> call(String category) async {
    return await repository.getTalesByCategory(category);
  }
}