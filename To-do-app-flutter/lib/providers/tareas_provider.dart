import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/tarea.dart';

class TareasProvider extends ChangeNotifier {
  List<Tarea> _tareas = [];
  List<Tarea> get tareas => _tareas;

  TareasProvider() {
    cargarTareas();
  }

  void agregarTarea(String titulo) {
    final nuevaTarea = Tarea(
      id: DateTime.now().toString(),
      titulo: titulo,
    );
    _tareas.add(nuevaTarea);
    guardarTareas();
    notifyListeners();
  }

  void actualizarTarea(String id, String nuevoTitulo) {
    final index = _tareas.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tareas[index].titulo = nuevoTitulo;
      guardarTareas();
      notifyListeners();
    }
  }

  void toggleCompletada(String id) {
    final index = _tareas.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tareas[index].completada = !_tareas[index].completada;
      guardarTareas();
      notifyListeners();
    }
  }

  void eliminarTarea(String id) {
    _tareas.removeWhere((t) => t.id == id);
    guardarTareas();
    notifyListeners();
  }

  int get totalTareas => _tareas.length;
  int get tareasCompletadas => _tareas.where((t) => t.completada).length;
  double get progreso => totalTareas == 0 ? 0 : tareasCompletadas / totalTareas;

  Future<void> guardarTareas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tareasJson = _tareas.map((t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList('tareas', tareasJson);
  }

  Future<void> cargarTareas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? tareasJson = prefs.getStringList('tareas');
    if (tareasJson != null) {
      _tareas = tareasJson.map((j) => Tarea.fromJson(jsonDecode(j))).toList();
      notifyListeners();
    }
  }
}
