import 'package:flutter/foundation.dart';
import '../../domain/entities/museum.dart';
import '../../domain/usecases/get_museums.dart';
import '../../core/di/injection_container.dart';

/// ViewModel for managing museums state and operations
class MuseumViewModel extends ChangeNotifier {
  final GetMuseums _getMuseums = sl<GetMuseums>();

  // États
  bool _isLoading = false;
  List<Museum> _museums = [];
  String? _errorMessage;
  String _selectedCountry = 'all';
  String _selectedRegion = 'all';

  // Getters
  bool get isLoading => _isLoading;
  List<Museum> get museums => _museums;
  String? get errorMessage => _errorMessage;
  String get selectedCountry => _selectedCountry;
  String get selectedRegion => _selectedRegion;

  // Museums filtrés
  List<Museum> get filteredMuseums {
    return _museums.where((museum) {
      bool countryMatch = _selectedCountry == 'all' || 
                         museum.country.toLowerCase().contains(_selectedCountry.toLowerCase());
      bool regionMatch = _selectedRegion == 'all' || 
                        museum.region.toLowerCase().contains(_selectedRegion.toLowerCase());
      return countryMatch && regionMatch;
    }).toList();
  }

  // Pays uniques
  List<String> get countries {
    final countries = _museums.map((museum) => museum.country).toSet().toList();
    countries.sort();
    return ['all', ...countries];
  }

  // Régions uniques
  List<String> get regions {
    final regions = _museums.map((museum) => museum.region).toSet().toList();
    regions.sort();
    return ['all', ...regions];
  }

  /// Charger tous les musées
  Future<void> loadMuseums() async {
    _setLoading(true);
    _clearError();

    try {
      final result = await _getMuseums();
      result.fold(
        (failure) => _setError(failure.message),
        (museums) => _setMuseums(museums),
      );
    } catch (e) {
      _setError('Erreur inattendue: $e');
    }

    _setLoading(false);
  }

  /// Rechercher des musées (filtre local)
  Future<void> searchMuseums(String query) async {
    if (query.isEmpty) {
      await loadMuseums();
      return;
    }

    // Pour l'instant, on recharge tout - implémentation de recherche locale sera ajoutée plus tard
    await loadMuseums();
  }

  /// Filtrer par pays
  void filterByCountry(String country) {
    _selectedCountry = country;
    notifyListeners();
  }

  /// Filtrer par région
  void filterByRegion(String region) {
    _selectedRegion = region;
    notifyListeners();
  }

  /// Réinitialiser les filtres
  void clearFilters() {
    _selectedCountry = 'all';
    _selectedRegion = 'all';
    notifyListeners();
  }

  // Méthodes privées
  void _setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void _setMuseums(List<Museum> museums) {
    _museums = museums;
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