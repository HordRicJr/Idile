import 'dart:convert';
import 'package:flutter/services.dart';

/// Abstract data source for local JSON assets
abstract class LocalDataSource {
  Future<List<Map<String, dynamic>>> loadJsonData(String assetPath);
}

/// Implementation of local data source for loading JSON from assets
class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<List<Map<String, dynamic>>> loadJsonData(String assetPath) async {
    try {
      final String jsonString = await rootBundle.loadString(assetPath);
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('Failed to load data from $assetPath: $e');
    }
  }
}