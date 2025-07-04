import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  String _language = 'es';
  String get language => _language;

  ThemeProvider();

  void toggleTheme(bool isOn) {
    _isDarkMode = isOn;
    savePreferences();
    notifyListeners();
  }

  void changeLanguage(String lang) {
    _language = lang;
    savePreferences();
    notifyListeners();
  }

  String getText(String key) {
    final texts = {
      'es': {
        'statistics': 'Estadísticas',
        'total': 'Total',
        'completed': 'Completadas',
        'progress': 'Progreso',
        'noTasks': 'No hay tareas. ¡Agrega una nueva tarea!',
        'addTask': 'Agregar Tarea',
        'editTask': 'Editar Tarea',
        'cancel': 'Cancelar',
        'add': 'Agregar',
        'save': 'Guardar',
        'dark': 'Oscuro',
        'light': 'Claro',
        'savePrefs': 'Guardar Preferencias',
      },
      'en': {
        'statistics': 'Statistics',
        'total': 'Total',
        'completed': 'Completed',
        'progress': 'Progress',
        'noTasks': 'No tasks. Add a new task!',
        'addTask': 'Add Task',
        'editTask': 'Edit Task',
        'cancel': 'Cancel',
        'add': 'Add',
        'save': 'Save',
        'dark': 'Dark',
        'light': 'Light',
        'savePrefs': 'Save Preferences',
      },
      'fr': {
        'statistics': 'Statistiques',
        'total': 'Total',
        'completed': 'Terminées',
        'progress': 'Progrès',
        'noTasks': 'Aucune tâche. Ajoutez-en une nouvelle !',
        'addTask': 'Ajouter Tâche',
        'editTask': 'Modifier Tâche',
        'cancel': 'Annuler',
        'add': 'Ajouter',
        'save': 'Enregistrer',
        'dark': 'Sombre',
        'light': 'Clair',
        'savePrefs': 'Sauvegarder Préférences',
      },
    };

    return texts[_language]?[key] ?? key;
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _language = prefs.getString('language') ?? 'es';
    notifyListeners();
  }

  Future<void> savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    await prefs.setString('language', _language);
  }
}
