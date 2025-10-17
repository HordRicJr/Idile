import 'package:flutter/foundation.dart';
import '../../domain/entities/african_kingdom.dart';
import '../../domain/usecases/get_kingdoms.dart';
import '../../core/di/injection_container.dart';

class AfricanKingdomViewModel extends ChangeNotifier {
  final GetKingdoms _getKingdoms = sl<GetKingdoms>();

  List<AfricanKingdom> _kingdoms = [];
  bool _isLoading = false;
  String? _error;

  List<AfricanKingdom> get kingdoms => _kingdoms;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getKingdoms() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _getKingdoms();
    result.fold(
      (failure) {
        _error = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (kingdomsList) {
        _kingdoms = kingdomsList;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}