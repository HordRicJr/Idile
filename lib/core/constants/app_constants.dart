/// Application constants for Idile - African Heritage App
class AppConstants {
  // API Configuration
  static const String baseUrl = 'https://api.idile.com';
  static const String apiVersion = 'v1';
  
  // Database Configuration
  static const String databaseName = 'idile_database.db';
  static const int databaseVersion = 1;
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Cache Configuration
  static const Duration cacheExpiration = Duration(hours: 24);
  static const String cacheKeyPrefix = 'idile_cache_';
  
  // Image Configuration
  static const String placeholderImageUrl = 'assets/images/placeholder.png';
  static const double defaultImageAspectRatio = 16 / 9;
  
  // Categories
  static const List<String> figureCategories = [
    'king',
    'queen',
    'warrior',
    'scholar',
    'artist',
    'leader',
    'explorer',
    'inventor',
  ];
  
  static const List<String> taleCategories = [
    'moral_tale',
    'legend',
    'myth',
    'folk_story',
    'creation_story',
    'heroic_tale',
  ];
  
  static const List<String> artCategories = [
    'sculpture',
    'painting',
    'textile',
    'mask',
    'jewelry',
    'pottery',
    'weapon',
    'instrument',
  ];
  
  static const List<String> siteCategories = [
    'temple',
    'palace',
    'archaeological_site',
    'monument',
    'fortress',
    'burial_site',
    'rock_art',
  ];
  
  // Age Groups
  static const List<String> ageGroups = [
    'children',
    'teenagers',
    'adults',
    'all_ages',
  ];
  
  // Languages (ISO 639-1 codes)
  static const List<String> supportedLanguages = [
    'en', // English
    'fr', // French
    'ar', // Arabic
    'sw', // Swahili
    'ha', // Hausa
    'yo', // Yoruba
    'ig', // Igbo
    'am', // Amharic
    'zu', // Zulu
    'xh', // Xhosa
  ];
  
  // Regions
  static const List<String> africanRegions = [
    'north_africa',
    'west_africa',
    'central_africa',
    'east_africa',
    'southern_africa',
  ];
}