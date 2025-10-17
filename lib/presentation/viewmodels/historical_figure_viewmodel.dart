import 'package:flutter/foundation.dart';
import '../../domain/entities/historical_figure.dart';
import '../../domain/usecases/get_historical_figures.dart';
import '../../domain/usecases/search_historical_figures.dart';
import '../../core/di/injection_container.dart';

/// ViewModel for managing historical figures state and operations
class HistoricalFigureViewModel extends ChangeNotifier {
  final GetHistoricalFigures _getHistoricalFigures = sl<GetHistoricalFigures>();
  final SearchHistoricalFigures _searchHistoricalFigures = sl<SearchHistoricalFigures>();

  // États
  bool _isLoading = false;
  List<HistoricalFigure> _figures = [];
  String? _errorMessage;
  String _selectedCategory = 'all';
  String _selectedRegion = 'all';

  // Getters
  bool get isLoading => _isLoading;
  List<HistoricalFigure> get figures => _figures;
  String? get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;
  String get selectedRegion => _selectedRegion;

  // Figures filtrées
  List<HistoricalFigure> get filteredFigures {
    return _figures.where((figure) {
      bool categoryMatch = _selectedCategory == 'all' || 
                          figure.category == _selectedCategory;
      bool regionMatch = _selectedRegion == 'all' || 
                        figure.region == _selectedRegion;
      return categoryMatch && regionMatch;
    }).toList();
  }

  /// Charger toutes les figures historiques
  Future<void> loadHistoricalFigures() async {
    _setLoading(true);
    _clearError();

    try {
      final result = await _getHistoricalFigures();
      result.fold(
        (failure) => _setError(failure.message),
        (figures) => _setFigures(figures),
      );
    } catch (e) {
      _setError('Erreur inattendue: $e');
    }

    _setLoading(false);
  }

  /// Rechercher des figures historiques
  Future<void> searchFigures(String query) async {
    if (query.isEmpty) {
      await loadHistoricalFigures();
      return;
    }

    _setLoading(true);
    _clearError();

    try {
      final result = await _searchHistoricalFigures(query);
      result.fold(
        (failure) => _setError(failure.message),
        (figures) => _setFigures(figures),
      );
    } catch (e) {
      _setError('Erreur de recherche: $e');
    }

    _setLoading(false);
  }

  /// Filtrer par catégorie
  void filterByCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  /// Filtrer par région
  void filterByRegion(String region) {
    _selectedRegion = region;
    notifyListeners();
  }

  /// Réinitialiser les filtres
  void clearFilters() {
    _selectedCategory = 'all';
    _selectedRegion = 'all';
    notifyListeners();
  }

  // Méthodes privées
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setFigures(List<HistoricalFigure> figures) {
    _figures = figures;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}