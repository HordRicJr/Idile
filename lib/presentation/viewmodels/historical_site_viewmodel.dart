import 'package:flutter/foundation.dart';
import '../../domain/entities/historical_site.dart';
import '../../domain/usecases/get_historical_sites.dart';
import '../../core/di/injection_container.dart';

/// ViewModel for managing historical sites state and operations
class HistoricalSiteViewModel extends ChangeNotifier {
  final GetHistoricalSites _getHistoricalSites = sl<GetHistoricalSites>();

  // États
  bool _isLoading = false;
  List<HistoricalSite> _sites = [];
  String? _errorMessage;
  String _selectedLocation = 'all';
  String _selectedPeriod = 'all';

  // Getters
  bool get isLoading => _isLoading;
  List<HistoricalSite> get sites => _sites;
  String? get errorMessage => _errorMessage;
  String get selectedLocation => _selectedLocation;
  String get selectedPeriod => _selectedPeriod;

  // Sites filtrés
  List<HistoricalSite> get filteredSites {
    return _sites.where((site) {
      bool locationMatch = _selectedLocation == 'all' || 
                          site.location.toLowerCase().contains(_selectedLocation.toLowerCase());
      bool periodMatch = _selectedPeriod == 'all' || 
                        site.period.toLowerCase().contains(_selectedPeriod.toLowerCase());
      return locationMatch && periodMatch;
    }).toList();
  }

  // Locations uniques
  List<String> get locations {
    final locations = _sites.map((site) => site.location).toSet().toList();
    locations.sort();
    return ['all', ...locations];
  }

  // Périodes uniques
  List<String> get periods {
    final periods = _sites.map((site) => site.period).toSet().toList();
    periods.sort();
    return ['all', ...periods];
  }

  /// Charger tous les sites historiques
  Future<void> loadSites() async {
    _setLoading(true);
    _clearError();

    try {
      final result = await _getHistoricalSites();
      result.fold(
        (failure) => _setError(failure.message),
        (sites) => _setSites(sites),
      );
    } catch (e) {
      _setError('Erreur inattendue: $e');
    }

    _setLoading(false);
  }

  /// Rechercher des sites historiques (filtre local)
  Future<void> searchSites(String query) async {
    if (query.isEmpty) {
      await loadSites();
      return;
    }

    // Pour l'instant, on recharge tout - implémentation de recherche locale sera ajoutée plus tard
    await loadSites();
  }

  /// Filtrer par location
  void filterByLocation(String location) {
    _selectedLocation = location;
    notifyListeners();
  }

  /// Filtrer par période
  void filterByPeriod(String period) {
    _selectedPeriod = period;
    notifyListeners();
  }

  /// Réinitialiser les filtres
  void clearFilters() {
    _selectedLocation = 'all';
    _selectedPeriod = 'all';
    notifyListeners();
  }

  // Méthodes privées
  void _setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void _setSites(List<HistoricalSite> sites) {
    _sites = sites;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}