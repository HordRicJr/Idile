import 'package:flutter/foundation.dart';
import '../../domain/entities/african_festival.dart';
import '../../domain/usecases/get_festivals.dart';
import '../../core/di/injection_container.dart';

class AfricanFestivalViewModel extends ChangeNotifier {
  final GetFestivals _getFestivals = sl<GetFestivals>();

  List<AfricanFestival> _festivals = [];
  bool _isLoading = false;
  String? _error;

  List<AfricanFestival> get festivals => _festivals;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getFestivals() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _getFestivals();
    result.fold(
      (failure) {
        _error = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (festivalsList) {
        _festivals = festivalsList;
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