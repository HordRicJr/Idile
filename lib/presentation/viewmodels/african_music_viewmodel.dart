import 'package:flutter/foundation.dart';
import '../../domain/entities/african_music.dart';
import '../../domain/usecases/get_music.dart';
import '../../core/di/injection_container.dart';

class AfricanMusicViewModel extends ChangeNotifier {
  final GetMusic _getMusic = sl<GetMusic>();

  List<AfricanMusic> _music = [];
  bool _isLoading = false;
  String? _error;

  List<AfricanMusic> get music => _music;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getMusic() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _getMusic();
    result.fold(
      (failure) {
        _error = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (musicList) {
        _music = musicList;
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