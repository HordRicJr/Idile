import 'package:flutter/foundation.dart';
import '../../domain/entities/african_deity.dart';
import '../../domain/usecases/get_deities.dart';
import '../../core/di/injection_container.dart';

/// ViewModel for managing African deities state and operations
class AfricanDeityViewModel extends ChangeNotifier {
  final GetDeities _getDeities = sl<GetDeities>();

  // États
  bool _isLoading = false;
  List<AfricanDeity> _deities = [];
  String? _errorMessage;
  String _selectedRegion = 'all';
  String _selectedDomain = 'all';

  // Getters
  bool get isLoading => _isLoading;
  List<AfricanDeity> get deities => _deities;
  String? get errorMessage => _errorMessage;
  String get selectedRegion => _selectedRegion;
  String get selectedDomain => _selectedDomain;

  // Deities filtrées
  List<AfricanDeity> get filteredDeities {
    return _deities.where((deity) {
      bool regionMatch = _selectedRegion == 'all' || 
                        deity.origin.toLowerCase().contains(_selectedRegion.toLowerCase());
      bool domainMatch = _selectedDomain == 'all' || 
                        deity.domain.toLowerCase().contains(_selectedDomain.toLowerCase());
      return regionMatch && domainMatch;
    }).toList();
  }

  // Régions uniques
  List<String> get regions {
    final regions = _deities.map((deity) => deity.origin).toSet().toList();
    regions.sort();
    return ['all', ...regions];
  }

  // Domaines uniques
  List<String> get domains {
    final domains = _deities.map((deity) => deity.domain).toSet().toList();
    domains.sort();
    return ['all', ...domains];
  }

  /// Charger toutes les divinités
  Future<void> loadDeities() async {
    _setLoading(true);
    _clearError();

    try {
      final result = await _getDeities();
      result.fold(
        (failure) => _setError(failure.message),
        (deities) => _setDeities(deities),
      );
    } catch (e) {
      _setError('Erreur inattendue: $e');
    }

    _setLoading(false);
  }

  /// Rechercher des divinités (filtre local)
  Future<void> searchDeities(String query) async {
    if (query.isEmpty) {
      await loadDeities();
      return;
    }

    // Pour l'instant, on recharge tout - implémentation de recherche locale sera ajoutée plus tard
    await loadDeities();
  }

  /// Filtrer par région
  void filterByRegion(String region) {
    _selectedRegion = region;
    notifyListeners();
  }

  /// Filtrer par domaine
  void filterByDomain(String domain) {
    _selectedDomain = domain;
    notifyListeners();
  }

  /// Réinitialiser les filtres
  void clearFilters() {
    _selectedRegion = 'all';
    _selectedDomain = 'all';
    notifyListeners();
  }

  // Méthodes privées
  void _setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void _setDeities(List<AfricanDeity> deities) {
    _deities = deities;
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