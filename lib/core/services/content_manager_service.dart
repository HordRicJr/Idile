import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/historical_figure.dart';
import '../../domain/entities/museum.dart';
import '../../domain/entities/historical_site.dart';
import '../../domain/entities/tale.dart';
import '../../domain/entities/art_object.dart';
import '../../domain/entities/quote.dart';

import '../../domain/entities/media_content.dart';
import '../../domain/entities/african_deity.dart';
import '../../domain/entities/african_kingdom.dart';
import '../../domain/entities/african_festival.dart';
import '../../domain/entities/african_music.dart';

/// Service for managing local content data
class ContentManagerService {
  static ContentManagerService? _instance;
  static ContentManagerService get instance => _instance ??= ContentManagerService._();
  ContentManagerService._();

  // Cache for loaded content
  Map<String, List<dynamic>> _contentCache = {};

  /// Load historical figures from local JSON data
  Future<List<HistoricalFigure>> loadHistoricalFigures() async {
    if (_contentCache.containsKey('historical_figures')) {
      return _contentCache['historical_figures']!.cast<HistoricalFigure>();
    }

    try {
      final String jsonString = await rootBundle.loadString('assets/data/historical_figures.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      
      final List<HistoricalFigure> figures = jsonList.map((json) => 
        HistoricalFigure(
          id: json['id'],
          name: json['name'],
          title: json['title'],
          biography: json['biography'],
          birthDate: json['birthDate'],
          deathDate: json['deathDate'],
          country: json['country'],
          region: json['region'],
          imageUrl: json['imageUrl'],
          achievements: List<String>.from(json['achievements']),
          period: json['period'],
          category: json['category'],
        )
      ).toList();

      _contentCache['historical_figures'] = figures;
      return figures;
    } catch (e) {
      return [];
    }
  }

  /// Load museums from local JSON data
  Future<List<Museum>> loadMuseums() async {
    if (_contentCache.containsKey('museums')) {
      return _contentCache['museums']!.cast<Museum>();
    }

    try {
      final String jsonString = await rootBundle.loadString('assets/data/museums.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      
      final List<Museum> museums = jsonList.map((json) => 
        Museum(
          id: json['id'],
          name: json['name'],
          description: json['description'],
          address: json['address'],
          city: json['city'],
          country: json['country'],
          region: json['region'],
          imageUrl: json['imageUrl'],
          collections: List<String>.from(json['collections']),
          openingHours: json['openingHours'],
          contactInfo: json['contactInfo'],
          rating: json['rating'].toDouble(),
          website: json['website'],
          isVirtualTourAvailable: json['isVirtualTourAvailable'],
          mediaGallery: (json['mediaGallery'] as List?)?.map((media) =>
            MediaContent(
              id: media['id'],
              type: media['type'],
              url: media['url'],
              title: media['title'],
              description: media['description'],
              thumbnailUrl: media['thumbnailUrl'],
              duration: media['duration'],
              resolution: media['resolution'],
              metadata: media['metadata'],
            )
          ).toList() ?? [],
          panorama360Url: json['panorama360Url'],
        )
      ).toList();

      _contentCache['museums'] = museums;
      return museums;
    } catch (e) {
      return [];
    }
  }

  /// Load tales from local JSON data
  Future<List<Tale>> loadTales() async {
    if (_contentCache.containsKey('tales')) {
      return _contentCache['tales']!.cast<Tale>();
    }

    try {
      final String jsonString = await rootBundle.loadString('assets/data/tales.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      
      final List<Tale> tales = jsonList.map((json) => 
        Tale(
          id: json['id'],
          title: json['title'],
          content: json['content'],
          summary: json['summary'],
          origin: json['origin'],
          language: json['language'],
          category: json['category'],
          characters: List<String>.from(json['characters']),
          moralLesson: json['moralLesson'],
          narrator: json['narrator'],
          imageUrl: json['imageUrl'],
          duration: json['duration'],
          ageGroup: json['ageGroup'],
        )
      ).toList();

      _contentCache['tales'] = tales;
      return tales;
    } catch (e) {
      return [];
    }
  }

  /// Load art objects from local JSON data
  Future<List<ArtObject>> loadArtObjects() async {
    if (_contentCache.containsKey('art_objects')) {
      return _contentCache['art_objects']!.cast<ArtObject>();
    }

    try {
      final String jsonString = await rootBundle.loadString('assets/data/art_objects.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      
      final List<ArtObject> artObjects = jsonList.map((json) => 
        ArtObject(
          id: json['id'],
          name: json['name'],
          description: json['description'],
          artist: json['artist'],
          period: json['period'],
          material: json['material'],
          technique: json['technique'],
          origin: json['origin'],
          currentLocation: json['currentLocation'],
          imageUrls: List<String>.from(json['imageUrls']),
          category: json['category'],
          culturalSignificance: json['culturalSignificance'],
          dimensions: json['dimensions'],
          isOnDisplay: json['isOnDisplay'],
        )
      ).toList();

      _contentCache['art_objects'] = artObjects;
      return artObjects;
    } catch (e) {
      return [];
    }
  }

  /// Load quotes from local JSON data
  Future<List<Quote>> loadQuotes() async {
    if (_contentCache.containsKey('quotes')) {
      return _contentCache['quotes']!.cast<Quote>();
    }

    try {
      final String jsonString = await rootBundle.loadString('assets/data/quotes.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      
      final List<Quote> quotes = jsonList.map((json) => 
        Quote(
          id: json['id'],
          text: json['text'],
          author: json['author'],
          authorTitle: json['authorTitle'],
          context: json['context'],
          period: json['period'],
          language: json['language'],
          originalLanguage: json['originalLanguage'],
          category: json['category'],
          source: json['source'],
          imageUrl: json['imageUrl'],
        )
      ).toList();

      _contentCache['quotes'] = quotes;
      return quotes;
    } catch (e) {
      return [];
    }
  }

  /// Load historical sites from local JSON data
  Future<List<HistoricalSite>> loadHistoricalSites() async {
    if (_contentCache.containsKey('historical_sites')) {
      return _contentCache['historical_sites']!.cast<HistoricalSite>();
    }

    try {
      final String jsonString = await rootBundle.loadString('assets/data/historical_sites.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      
      final List<HistoricalSite> sites = jsonList.map((json) => 
        HistoricalSite(
          id: json['id'],
          name: json['name'],
          description: json['description'],
          location: json['location'],
          country: json['country'],
          region: json['region'],
          period: json['period'],
          significance: json['significance'],
          imageUrls: List<String>.from(json['imageUrls']),
          category: json['category'],
          isUnescoSite: json['isUnescoSite'],
          visitInfo: json['visitInfo'],
        )
      ).toList();

      _contentCache['historical_sites'] = sites;
      return sites;
    } catch (e) {
      return [];
    }
  }

  /// Load African deities from local JSON data
  Future<List<AfricanDeity>> loadAfricanDeities() async {
    if (_contentCache.containsKey('african_deities')) {
      return _contentCache['african_deities']!.cast<AfricanDeity>();
    }

    try {
      final String jsonString = await rootBundle.loadString('assets/data/african_deities.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      
      final List<AfricanDeity> deities = jsonList.map((json) => 
        AfricanDeity(
          id: json['id'],
          name: json['name'],
          alternativeNames: json['alternativeNames'],
          description: json['description'],
          mythology: json['mythology'],
          origin: json['origin'],
          religion: json['religion'],
          domain: json['domain'],
          attributes: List<String>.from(json['attributes']),
          symbols: List<String>.from(json['symbols']),
          imageUrl: json['imageUrl'],
          stories: List<String>.from(json['stories']),
          worship: json['worship'],
          significance: json['significance'],
          family: json['family'],
        )
      ).toList();

      _contentCache['african_deities'] = deities;
      return deities;
    } catch (e) {
      return [];
    }
  }

  /// Load African kingdoms from local JSON data
  Future<List<AfricanKingdom>> loadAfricanKingdoms() async {
    if (_contentCache.containsKey('african_kingdoms')) {
      return _contentCache['african_kingdoms']!.cast<AfricanKingdom>();
    }

    try {
      final String jsonString = await rootBundle.loadString('assets/data/african_kingdoms.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      
      final List<AfricanKingdom> kingdoms = jsonList.map((json) => 
        AfricanKingdom(
          id: json['id'],
          name: json['name'],
          description: json['description'],
          foundedDate: json['foundedDate'],
          endDate: json['endDate'],
          location: json['location'],
          region: json['region'],
          territories: List<String>.from(json['territories']),
          capital: json['capital'],
          rulers: List<String>.from(json['rulers']),
          government: json['government'],
          economy: json['economy'],
          culture: json['culture'],
          military: json['military'],
          decline: json['decline'],
          legacy: json['legacy'],
          imageUrl: json['imageUrl'],
          achievements: List<String>.from(json['achievements']),
        )
      ).toList();

      _contentCache['african_kingdoms'] = kingdoms;
      return kingdoms;
    } catch (e) {
      return [];
    }
  }

  /// Load African festivals from local JSON data
  Future<List<AfricanFestival>> loadAfricanFestivals() async {
    if (_contentCache.containsKey('african_festivals')) {
      return _contentCache['african_festivals']!.cast<AfricanFestival>();
    }

    try {
      final String jsonString = await rootBundle.loadString('assets/data/african_festivals.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      
      final List<AfricanFestival> festivals = jsonList.map((json) => 
        AfricanFestival(
          id: json['id'],
          name: json['name'],
          description: json['description'],
          origin: json['origin'],
          period: json['period'],
          frequency: json['frequency'],
          purpose: json['purpose'],
          activities: List<String>.from(json['activities']),
          participants: List<String>.from(json['participants']),
          significance: json['significance'],
          history: json['history'],
          traditions: List<String>.from(json['traditions']),
          modernPractice: json['modernPractice'],
          imageUrl: json['imageUrl'],
          mediaUrls: List<String>.from(json['mediaUrls']),
        )
      ).toList();

      _contentCache['african_festivals'] = festivals;
      return festivals;
    } catch (e) {
      return [];
    }
  }

  /// Load African music from local JSON data
  Future<List<AfricanMusic>> loadAfricanMusic() async {
    if (_contentCache.containsKey('african_music')) {
      return _contentCache['african_music']!.cast<AfricanMusic>();
    }

    try {
      final String jsonString = await rootBundle.loadString('assets/data/african_music.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      
      final List<AfricanMusic> music = jsonList.map((json) => 
        AfricanMusic(
          id: json['id'],
          title: json['title'],
          artist: json['artist'],
          origin: json['origin'],
          genre: json['genre'],
          language: json['language'],
          description: json['description'],
          instruments: List<String>.from(json['instruments']),
          culturalContext: json['culturalContext'],
          meaning: json['meaning'],
          audioUrl: json['audioUrl'],
          imageUrl: json['imageUrl'],
          duration: json['duration'],
          period: json['period'],
          influence: json['influence'],
        )
      ).toList();

      _contentCache['african_music'] = music;
      return music;
    } catch (e) {
      return [];
    }
  }

  /// Clear content cache
  void clearCache() {
    _contentCache.clear();
  }

  /// Search across all content types
  Future<Map<String, List<dynamic>>> searchContent(String query) async {
    final Map<String, List<dynamic>> results = {};
    
    // Search historical figures
    final figures = await loadHistoricalFigures();
    results['historical_figures'] = figures.where((figure) =>
      figure.name.toLowerCase().contains(query.toLowerCase()) ||
      figure.biography.toLowerCase().contains(query.toLowerCase()) ||
      figure.achievements.any((achievement) => 
        achievement.toLowerCase().contains(query.toLowerCase()))
    ).toList();

    // Search museums
    final museums = await loadMuseums();
    results['museums'] = museums.where((museum) =>
      museum.name.toLowerCase().contains(query.toLowerCase()) ||
      museum.description.toLowerCase().contains(query.toLowerCase()) ||
      museum.city.toLowerCase().contains(query.toLowerCase())
    ).toList();

    // Search tales
    final tales = await loadTales();
    results['tales'] = tales.where((tale) =>
      tale.title.toLowerCase().contains(query.toLowerCase()) ||
      tale.summary.toLowerCase().contains(query.toLowerCase()) ||
      tale.moralLesson.toLowerCase().contains(query.toLowerCase())
    ).toList();

    return results;
  }
}