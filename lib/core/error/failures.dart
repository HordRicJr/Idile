import 'package:equatable/equatable.dart';

/// Base class for all failures that can occur in the app
abstract class Failure extends Equatable {
  final String message;
  
  const Failure({required this.message});
  
  @override
  List<Object> get props => [message];
}

/// Failure that occurs when there's an issue with caching/local storage
class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

/// Failure that occurs when there's a network error
class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});
}

/// Failure that occurs when server returns an error
class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

/// Failure that occurs when input validation fails
class ValidationFailure extends Failure {
  const ValidationFailure({required super.message});
}