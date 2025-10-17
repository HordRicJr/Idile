import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/tale.dart';
import '../../domain/entities/historical_figure.dart';
import '../../domain/entities/african_festival.dart';
import '../../domain/entities/african_kingdom.dart';

/// Service for loading and managing content data from JSON assets
class ContentDataService {
  static const String _dataPath = 'assets/data/';

  /// Load tales from JSON
  static Future<List<Tale>> loadTales() async {
    try {
      final String jsonString = await rootBundle.loadString('${_dataPath}tales.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => Tale.fromJson(json)).toList();
    } catch (e) {
      print('Error loading tales: $e');
      return [];
    }
  }

  /// Load historical figures from JSON
  static Future<List<HistoricalFigure>> loadHistoricalFigures() async {
    try {
      final String jsonString = await rootBundle.loadString('${_dataPath}historical_figures.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => HistoricalFigure.fromJson(json)).toList();
    } catch (e) {
      print('Error loading historical figures: $e');
      return [];
    }
  }

  /// Load festivals from JSON
  static Future<List<AfricanFestival>> loadFestivals() async {
    try {
      final String jsonString = await rootBundle.loadString('${_dataPath}african_festivals.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => AfricanFestival.fromJson(json)).toList();
    } catch (e) {
      print('Error loading festivals: $e');
      return [];
    }
  }

  /// Load kingdoms from JSON
  static Future<List<AfricanKingdom>> loadKingdoms() async {
    try {
      final String jsonString = await rootBundle.loadString('${_dataPath}african_kingdoms.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => AfricanKingdom.fromJson(json)).toList();
    } catch (e) {
      print('Error loading kingdoms: $e');
      return [];
    }
  }

  // TODO: Implement fromJson methods for these entities
  // /// Load historical sites from JSON
  // static Future<List<HistoricalSite>> loadHistoricalSites() async {
  //   try {
  //     final String jsonString = await rootBundle.loadString('${_dataPath}historical_sites.json');
  //     final List<dynamic> jsonList = json.decode(jsonString);
  //     return jsonList.map((json) => HistoricalSite.fromJson(json)).toList();
  //   } catch (e) {
  //     print('Error loading historical sites: $e');
  //     return [];
  //   }
  // }

  // /// Load art objects from JSON
  // static Future<List<ArtObject>> loadArtObjects() async {
  //   try {
  //     final String jsonString = await rootBundle.loadString('${_dataPath}art_objects.json');
  //     final List<dynamic> jsonList = json.decode(jsonString);
  //     return jsonList.map((json) => ArtObject.fromJson(json)).toList();
  //   } catch (e) {
  //     print('Error loading art objects: $e');
  //     return [];
  //   }
  // }

  // /// Load museums from JSON
  // static Future<List<Museum>> loadMuseums() async {
  //   try {
  //     final String jsonString = await rootBundle.loadString('${_dataPath}museums.json');
  //     final List<dynamic> jsonList = json.decode(jsonString);
  //     return jsonList.map((json) => Museum.fromJson(json)).toList();
  //   } catch (e) {
  //     print('Error loading museums: $e');
  //     return [];
  //   }
  // }

  // /// Load music from JSON
  // static Future<List<AfricanMusic>> loadMusic() async {
  //   try {
  //     final String jsonString = await rootBundle.loadString('${_dataPath}african_music.json');
  //     final List<dynamic> jsonList = json.decode(jsonString);
  //     return jsonList.map((json) => AfricanMusic.fromJson(json)).toList();
  //   } catch (e) {
  //     print('Error loading music: $e');
  //     return [];
  //   }
  // }

  /// Load all content by category
  static Future<List<dynamic>> loadContentByCategory(String categoryId) async {
    switch (categoryId) {
      case 'tales':
        return await loadTales();
      case 'figures':
        return await loadHistoricalFigures();
      case 'festivals':
        return await loadFestivals();
      case 'kingdoms':
        return await loadKingdoms();
      // Temporarily disable these until fromJson is implemented
      // case 'sites':
      //   return await loadHistoricalSites();
      // case 'art':
      //   return await loadArtObjects();
      // case 'museums':
      //   return await loadMuseums();
      // case 'music':
      //   return await loadMusic();
      case 'all':
        // Load a sample from each working category
        final tales = await loadTales();
        final figures = await loadHistoricalFigures();
        final festivals = await loadFestivals();
        final allContent = <dynamic>[];
        allContent.addAll(tales.take(2));
        allContent.addAll(figures.take(2));
        allContent.addAll(festivals.take(2));
        return allContent;
      default:
        return [];
    }
  }

  /// Get category information
  static Map<String, dynamic> getCategoryInfo(String categoryId) {
    final categoryInfoMap = {
      'tales': {
        'title': 'Contes Traditionnels',
        'description': 'Découvrez les contes traditionnels africains, riches en sagesse et en enseignements culturels transmis de génération en génération.',
        'icon': 'auto_stories_outlined',
        'color': 'primary',
      },
      'figures': {
        'title': 'Figures Historiques',
        'description': 'Rencontrez les grandes figures historiques qui ont marqué l\'histoire africaine et mondiale.',
        'icon': 'person_outline',
        'color': 'accent',
      },
      'festivals': {
        'title': 'Festivals Culturels',
        'description': 'Participez aux célébrations culturelles qui rythment la vie sociale africaine.',
        'icon': 'celebration_outlined',
        'color': 'accentSecondary',
      },
      'kingdoms': {
        'title': 'Royaumes Africains',
        'description': 'Explorez les grands royaumes et empires qui ont façonné l\'histoire africaine.',
        'icon': 'castle_outlined',
        'color': 'accent',
      },
      'sites': {
        'title': 'Sites Historiques',
        'description': 'Visitez virtuellement les sites historiques et monuments emblématiques du continent africain.',
        'icon': 'location_city_outlined',
        'color': 'secondary',
      },
      'art': {
        'title': 'Art & Artéfacts',
        'description': 'Admirez l\'art traditionnel africain et découvrez les techniques ancestrales.',
        'icon': 'palette_outlined',
        'color': 'primary',
      },
      'museums': {
        'title': 'Musées',
        'description': 'Visitez les musées dédiés à la préservation du patrimoine africain.',
        'icon': 'museum_outlined',
        'color': 'secondary',
      },
      'music': {
        'title': 'Musique Traditionnelle',
        'description': 'Explorez la diversité musicale africaine, des rythmes ancestraux aux influences contemporaines.',
        'icon': 'music_note_outlined',
        'color': 'secondary',
      },
    };

    return categoryInfoMap[categoryId] ?? categoryInfoMap['all']!;
  }
}