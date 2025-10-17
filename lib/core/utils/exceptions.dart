/// Custom exception classes for the application
abstract class AppException implements Exception {
  final String message;
  final String? code;
  
  const AppException(this.message, {this.code});
  
  @override
  String toString() => 'AppException: $message ${code != null ? '($code)' : ''}';
}

/// Network related exceptions
class NetworkException extends AppException {
  const NetworkException(String message, {String? code}) : super(message, code: code);
}

/// Server related exceptions
class ServerException extends AppException {
  const ServerException(String message, {String? code}) : super(message, code: code);
}

/// Cache related exceptions
class CacheException extends AppException {
  const CacheException(String message, {String? code}) : super(message, code: code);
}

/// Data parsing exceptions
class DataException extends AppException {
  const DataException(String message, {String? code}) : super(message, code: code);
}

/// Authentication related exceptions
class AuthException extends AppException {
  const AuthException(String message, {String? code}) : super(message, code: code);
}

/// Validation related exceptions
class ValidationException extends AppException {
  const ValidationException(String message, {String? code}) : super(message, code: code);
}