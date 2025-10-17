import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// ViewModel for managing content creation and editing
class ContentEditorViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  /// Save content to local JSON files
  Future<void> saveContent(String contentType, Map<String, dynamic> contentData) async {
    _setLoading(true);
    _clearMessages();

    try {
      // Generate unique ID
      contentData['id'] = '${contentType}_${DateTime.now().millisecondsSinceEpoch}';
      
      // Get the directory for storing user-generated content
      final directory = await getApplicationDocumentsDirectory();
      final userContentDir = Directory('${directory.path}/user_content');
      
      if (!await userContentDir.exists()) {
        await userContentDir.create(recursive: true);
      }

      // Read existing content
      final fileName = '${contentType}s.json';
      final file = File('${userContentDir.path}/$fileName');
      
      List<dynamic> existingContent = [];
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        existingContent = json.decode(jsonString);
      }

      // Add new content
      existingContent.add(contentData);

      // Write back to file
      await file.writeAsString(json.encode(existingContent));

      _setSuccessMessage('Content saved successfully!');
      
    } catch (e) {
      _setErrorMessage('Failed to save content: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Load user-generated content
  Future<List<dynamic>> loadUserContent(String contentType) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final userContentDir = Directory('${directory.path}/user_content');
      
      final fileName = '${contentType}s.json';
      final file = File('${userContentDir.path}/$fileName');
      
      if (!await file.exists()) {
        return [];
      }

      final jsonString = await file.readAsString();
      return json.decode(jsonString);
      
    } catch (e) {
      _setErrorMessage('Failed to load user content: ${e.toString()}');
      return [];
    }
  }

  /// Edit existing content
  Future<void> editContent(String contentType, String contentId, Map<String, dynamic> updatedData) async {
    _setLoading(true);
    _clearMessages();

    try {
      final directory = await getApplicationDocumentsDirectory();
      final userContentDir = Directory('${directory.path}/user_content');
      
      final fileName = '${contentType}s.json';
      final file = File('${userContentDir.path}/$fileName');
      
      if (!await file.exists()) {
        throw Exception('Content file not found');
      }

      final jsonString = await file.readAsString();
      List<dynamic> content = json.decode(jsonString);

      // Find and update the content
      final index = content.indexWhere((item) => item['id'] == contentId);
      if (index == -1) {
        throw Exception('Content not found');
      }

      content[index] = updatedData;

      // Write back to file
      await file.writeAsString(json.encode(content));

      _setSuccessMessage('Content updated successfully!');
      
    } catch (e) {
      _setErrorMessage('Failed to update content: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Delete content
  Future<void> deleteContent(String contentType, String contentId) async {
    _setLoading(true);
    _clearMessages();

    try {
      final directory = await getApplicationDocumentsDirectory();
      final userContentDir = Directory('${directory.path}/user_content');
      
      final fileName = '${contentType}s.json';
      final file = File('${userContentDir.path}/$fileName');
      
      if (!await file.exists()) {
        throw Exception('Content file not found');
      }

      final jsonString = await file.readAsString();
      List<dynamic> content = json.decode(jsonString);

      // Remove the content
      content.removeWhere((item) => item['id'] == contentId);

      // Write back to file
      await file.writeAsString(json.encode(content));

      _setSuccessMessage('Content deleted successfully!');
      
    } catch (e) {
      _setErrorMessage('Failed to delete content: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Export user content to share
  Future<String?> exportUserContent() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final userContentDir = Directory('${directory.path}/user_content');
      
      if (!await userContentDir.exists()) {
        return null;
      }

      final Map<String, dynamic> allContent = {};
      
      // Collect all user content files
      final files = userContentDir.listSync().whereType<File>();
      for (final file in files) {
        if (file.path.endsWith('.json')) {
          final fileName = file.path.split('/').last.replaceAll('.json', '');
          final content = json.decode(await file.readAsString());
          allContent[fileName] = content;
        }
      }

      // Create export file
      final exportFile = File('${directory.path}/idile_user_content_export.json');
      await exportFile.writeAsString(json.encode({
        'exportDate': DateTime.now().toIso8601String(),
        'version': '1.0',
        'content': allContent,
      }));

      return exportFile.path;
      
    } catch (e) {
      _setErrorMessage('Failed to export content: ${e.toString()}');
      return null;
    }
  }

  /// Import user content
  Future<void> importUserContent(String filePath) async {
    _setLoading(true);
    _clearMessages();

    try {
      final importFile = File(filePath);
      if (!await importFile.exists()) {
        throw Exception('Import file not found');
      }

      final jsonString = await importFile.readAsString();
      final importData = json.decode(jsonString);

      if (!importData.containsKey('content')) {
        throw Exception('Invalid import file format');
      }

      final directory = await getApplicationDocumentsDirectory();
      final userContentDir = Directory('${directory.path}/user_content');
      
      if (!await userContentDir.exists()) {
        await userContentDir.create(recursive: true);
      }

      // Import each content type
      final Map<String, dynamic> content = importData['content'];
      for (final entry in content.entries) {
        final fileName = '${entry.key}.json';
        final file = File('${userContentDir.path}/$fileName');
        
        // Merge with existing content
        List<dynamic> existingContent = [];
        if (await file.exists()) {
          final existingJsonString = await file.readAsString();
          existingContent = json.decode(existingJsonString);
        }

        // Add imported content (avoiding duplicates by ID)
        final List<dynamic> importedContent = entry.value;
        for (final item in importedContent) {
          final existingIndex = existingContent.indexWhere((existing) => existing['id'] == item['id']);
          if (existingIndex == -1) {
            existingContent.add(item);
          }
        }

        await file.writeAsString(json.encode(existingContent));
      }

      _setSuccessMessage('Content imported successfully!');
      
    } catch (e) {
      _setErrorMessage('Failed to import content: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setErrorMessage(String message) {
    _errorMessage = message;
    _successMessage = null;
    notifyListeners();
  }

  void _setSuccessMessage(String message) {
    _successMessage = message;
    _errorMessage = null;
    notifyListeners();
  }

  void _clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  void clearMessages() {
    _clearMessages();
  }
}