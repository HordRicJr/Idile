import 'package:flutter/foundation.dart';
import '../../domain/entities/tale.dart';
import '../../domain/usecases/get_tales.dart';
import '../../core/di/injection_container.dart';

/// ViewModel for managing tales state and operations
class TaleViewModel extends ChangeNotifier {
  final GetTales _getTales = sl<GetTales>();

  List<Tale> _tales = [];
  List<Tale> get tales => _tales;

  Tale? _selectedTale;
  Tale? get selectedTale => _selectedTale;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Load all tales
  Future<void> loadTales() async {
    _setLoading(true);
    final result = await _getTales();
    result.fold(
      (failure) => _setError(failure.message),
      (tales) {
        _tales = tales;
        _clearError();
      },
    );
    _setLoading(false);
  }

  /// Set selected tale
  void setSelectedTale(Tale tale) {
    _selectedTale = tale;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearSelectedTale() {
    _selectedTale = null;
    notifyListeners();
  }
}