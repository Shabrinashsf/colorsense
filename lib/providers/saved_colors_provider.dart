import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SavedColor {
  final String name;
  final String hex;
  final bool isFavorite;

  SavedColor({required this.name, required this.hex, this.isFavorite = false});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'hex': hex,
      'isFavorite': isFavorite,
    };
  }

  factory SavedColor.fromMap(Map<String, dynamic> map) {
    return SavedColor(
      name: map['name'] ?? '',
      hex: map['hex'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
    );
  }
}

class SavedColorsNotifier extends Notifier<List<SavedColor>> {
  late Box<String> _box;

  @override
  List<SavedColor> build() {
    _initBox();
    return [];
  }

  Future<void> _initBox() async {
    _box = await Hive.openBox<String>('saved_colors_box');
    _loadFromBox();
  }

  void _loadFromBox() {
    final List<SavedColor> loaded = [];
    for (var i = 0; i < _box.length; i++) {
      final item = _box.getAt(i);
      if (item != null) {
        loaded.add(SavedColor.fromMap(jsonDecode(item)));
      }
    }
    state = loaded;
  }

  void saveColor(String name, String hex) {
    if (isSaved(hex)) return; // Prevent duplicate saves
    final color = SavedColor(name: name, hex: hex);
    _box.add(jsonEncode(color.toMap()));
    state = [...state, color];
  }

  void removeColor(String hex) {
    // Find index
    for (var i = 0; i < _box.length; i++) {
      final item = _box.getAt(i);
      if (item != null) {
        final decoded = jsonDecode(item);
        if (decoded['hex'] == hex) {
          _box.deleteAt(i);
          break;
        }
      }
    }
    _loadFromBox(); // reload state
  }

  bool isSaved(String hex) {
    return state.any((c) => c.hex == hex);
  }

  void toggleFavorite(String hex) {
    for (var i = 0; i < _box.length; i++) {
      final item = _box.getAt(i);
      if (item != null) {
        final decoded = jsonDecode(item);
        if (decoded['hex'] == hex) {
          decoded['isFavorite'] = !(decoded['isFavorite'] ?? false);
          _box.putAt(i, jsonEncode(decoded));
          break;
        }
      }
    }
    _loadFromBox();
  }
}

final savedColorsProvider = NotifierProvider<SavedColorsNotifier, List<SavedColor>>(SavedColorsNotifier.new);
