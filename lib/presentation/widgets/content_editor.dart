import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../../domain/entities/historical_figure.dart';

import '../../domain/entities/tale.dart';
import '../../core/constants/app_strings.dart';

/// Service for adding and editing content locally
class ContentEditorService {
  /// Add a new historical figure
  static Future<bool> addHistoricalFigure(HistoricalFigure figure) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/user_historical_figures.json');
      
      List<Map<String, dynamic>> figures = [];
      if (await file.exists()) {
        final content = await file.readAsString();
        final List<dynamic> jsonList = json.decode(content);
        figures = jsonList.cast<Map<String, dynamic>>();
      }
      
      figures.add({
        'id': figure.id,
        'name': figure.name,
        'title': figure.title,
        'biography': figure.biography,
        'birthDate': figure.birthDate,
        'deathDate': figure.deathDate,
        'country': figure.country,
        'region': figure.region,
        'imageUrl': figure.imageUrl,
        'achievements': figure.achievements,
        'period': figure.period,
        'category': figure.category,
        'isUserGenerated': true,
      });
      
      await file.writeAsString(json.encode(figures));
      return true;
    } catch (e) {
      debugPrint('Error adding historical figure: $e');
      return false;
    }
  }

  /// Add a new tale
  static Future<bool> addTale(Tale tale) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/user_tales.json');
      
      List<Map<String, dynamic>> tales = [];
      if (await file.exists()) {
        final content = await file.readAsString();
        final List<dynamic> jsonList = json.decode(content);
        tales = jsonList.cast<Map<String, dynamic>>();
      }
      
      tales.add({
        'id': tale.id,
        'title': tale.title,
        'content': tale.content,
        'summary': tale.summary,
        'origin': tale.origin,
        'language': tale.language,
        'category': tale.category,
        'characters': tale.characters,
        'moralLesson': tale.moralLesson,
        'narrator': tale.narrator,
        'imageUrl': tale.imageUrl,
        'duration': tale.duration,
        'ageGroup': tale.ageGroup,
        'isUserGenerated': true,
      });
      
      await file.writeAsString(json.encode(tales));
      return true;
    } catch (e) {
      debugPrint('Error adding tale: $e');
      return false;
    }
  }

  /// Load user-generated content
  static Future<List<HistoricalFigure>> loadUserHistoricalFigures() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/user_historical_figures.json');
      
      if (!await file.exists()) return [];
      
      final content = await file.readAsString();
      final List<dynamic> jsonList = json.decode(content);
      
      return jsonList.map((json) => HistoricalFigure(
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
      )).toList();
    } catch (e) {
      debugPrint('Error loading user historical figures: $e');
      return [];
    }
  }

  /// Load user-generated tales
  static Future<List<Tale>> loadUserTales() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/user_tales.json');
      
      if (!await file.exists()) return [];
      
      final content = await file.readAsString();
      final List<dynamic> jsonList = json.decode(content);
      
      return jsonList.map((json) => Tale(
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
      )).toList();
    } catch (e) {
      debugPrint('Error loading user tales: $e');
      return [];
    }
  }
}

/// Widget for editing/adding new historical figures
class HistoricalFigureEditor extends StatefulWidget {
  final HistoricalFigure? existingFigure;
  
  const HistoricalFigureEditor({
    Key? key,
    this.existingFigure,
  }) : super(key: key);

  @override
  State<HistoricalFigureEditor> createState() => _HistoricalFigureEditorState();
}

class _HistoricalFigureEditorState extends State<HistoricalFigureEditor> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _titleController;
  late TextEditingController _biographyController;
  late TextEditingController _birthDateController;
  late TextEditingController _deathDateController;
  late TextEditingController _countryController;
  late TextEditingController _regionController;
  late TextEditingController _imageUrlController;
  late TextEditingController _achievementsController;
  String _selectedPeriod = 'Ancient';
  String _selectedCategory = 'king';

  @override
  void initState() {
    super.initState();
    final figure = widget.existingFigure;
    
    _nameController = TextEditingController(text: figure?.name ?? '');
    _titleController = TextEditingController(text: figure?.title ?? '');
    _biographyController = TextEditingController(text: figure?.biography ?? '');
    _birthDateController = TextEditingController(text: figure?.birthDate ?? '');
    _deathDateController = TextEditingController(text: figure?.deathDate ?? '');
    _countryController = TextEditingController(text: figure?.country ?? '');
    _regionController = TextEditingController(text: figure?.region ?? '');
    _imageUrlController = TextEditingController(text: figure?.imageUrl ?? '');
    _achievementsController = TextEditingController(
      text: figure?.achievements.join(', ') ?? '',
    );
    
    if (figure != null) {
      _selectedPeriod = figure.period;
      _selectedCategory = figure.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingFigure == null 
            ? 'Add Historical Figure' 
            : 'Edit Historical Figure'),
        actions: [
          TextButton(
            onPressed: _saveFigure,
            child: const Text(
              AppStrings.save,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _biographyController,
                decoration: const InputDecoration(
                  labelText: AppStrings.biography,
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a biography';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _birthDateController,
                      decoration: const InputDecoration(
                        labelText: 'Birth Date',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _deathDateController,
                      decoration: const InputDecoration(
                        labelText: 'Death Date',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _countryController,
                      decoration: const InputDecoration(
                        labelText: AppStrings.country,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _regionController,
                      decoration: const InputDecoration(
                        labelText: AppStrings.region,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'Image URL or Path',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _achievementsController,
                decoration: const InputDecoration(
                  labelText: 'Achievements (comma separated)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedPeriod,
                      decoration: const InputDecoration(
                        labelText: AppStrings.period,
                        border: OutlineInputBorder(),
                      ),
                      items: ['Ancient', 'Medieval', 'Early Modern', 'Modern', 'Contemporary']
                          .map((period) => DropdownMenuItem(
                                value: period,
                                child: Text(period),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() => _selectedPeriod = value!);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: const InputDecoration(
                        labelText: AppStrings.category,
                        border: OutlineInputBorder(),
                      ),
                      items: ['king', 'queen', 'warrior', 'scholar', 'artist', 'leader']
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() => _selectedCategory = value!);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveFigure() async {
    if (!_formKey.currentState!.validate()) return;

    final figure = HistoricalFigure(
      id: widget.existingFigure?.id ?? 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: _nameController.text,
      title: _titleController.text,
      biography: _biographyController.text,
      birthDate: _birthDateController.text,
      deathDate: _deathDateController.text,
      country: _countryController.text,
      region: _regionController.text,
      imageUrl: _imageUrlController.text.isEmpty 
          ? 'assets/images/placeholder.png' 
          : _imageUrlController.text,
      achievements: _achievementsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
      period: _selectedPeriod,
      category: _selectedCategory,
    );

    final success = await ContentEditorService.addHistoricalFigure(figure);
    
    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.successSaved)),
        );
        Navigator.of(context).pop(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.errorSavingData)),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _biographyController.dispose();
    _birthDateController.dispose();
    _deathDateController.dispose();
    _countryController.dispose();
    _regionController.dispose();
    _imageUrlController.dispose();
    _achievementsController.dispose();
    super.dispose();
  }
}