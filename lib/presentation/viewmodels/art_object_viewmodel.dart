import 'package:flutter/foundation.dart';
import '../../domain/entities/art_object.dart';
import '../../domain/usecases/get_art_objects.dart';
import '../../core/di/injection_container.dart';

class ArtObjectViewModel extends ChangeNotifier {
  final GetArtObjects _getArtObjects = sl<GetArtObjects>();

  List<ArtObject> _artObjects = [];
  bool _isLoading = false;
  String? _error;

  List<ArtObject> get artObjects => _artObjects;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getArtObjects() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _getArtObjects();
    result.fold(
      (failure) {
        _error = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (artObjectsList) {
        _artObjects = artObjectsList;
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