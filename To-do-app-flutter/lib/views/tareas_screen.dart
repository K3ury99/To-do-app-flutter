import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tarea.dart';
import '../providers/tareas_provider.dart';
import '../providers/theme_provider.dart';

class TareasScreen extends StatelessWidget {
  const TareasScreen({super.key});

  void _mostrarDialogoAgregar(BuildContext context) {
    final controller = TextEditingController();
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(themeProvider.getText('addTask')),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: themeProvider.getText('addTask'),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(themeProvider.getText('cancel'))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                Provider.of<TareasProvider>(context, listen: false)
                    .agregarTarea(controller.text.trim());
                Navigator.pop(context);
              }
            },
            child: Text(themeProvider.getText('add')),
          ),
        ],
      ),
    );
  }

  void _mostrarDialogoEditar(BuildContext context, Tarea tarea) {
    final controller = TextEditingController(text: tarea.titulo);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(themeProvider.getText('editTask')),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: themeProvider.getText('editTask'),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(themeProvider.getText('cancel'))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                Provider.of<TareasProvider>(context, listen: false)
                    .actualizarTarea(tarea.id, controller.text.trim());
                Navigator.pop(context);
              }
            },
            child: Text(themeProvider.getText('save')),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, Tarea tarea) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Card(
      color: themeProvider.isDarkMode ? Colors.grey[800] : Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          tarea.titulo,
          style: TextStyle(
            fontSize: 18,
            color: themeProvider.isDarkMode ? Colors.white : Colors.black87,
            decoration: tarea.completada ? TextDecoration.lineThrough : null,
          ),
        ),
        leading: Checkbox(
          value: tarea.completada,
          activeColor: Colors.blue,
          onChanged: (_) => Provider.of<TareasProvider>(context, listen: false)
              .toggleCompletada(tarea.id),
        ),
        trailing: Wrap(
          spacing: 12,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blueAccent),
              onPressed: () => _mostrarDialogoEditar(context, tarea),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () =>
                  Provider.of<TareasProvider>(context, listen: false)
                      .eliminarTarea(tarea.id),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tareasProvider = Provider.of<TareasProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor:
          themeProvider.isDarkMode ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        title: const Text('Lista de Tareas!'),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: themeProvider.isDarkMode
                  ? [const Color.fromARGB(221, 255, 255, 255), Colors.black54]
                  : [Colors.blue.shade800, Colors.blue.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Estadísticas
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: themeProvider.isDarkMode ? Colors.grey[800] : null,
                gradient: themeProvider.isDarkMode
                    ? null
                    : LinearGradient(
                        colors: [Colors.blue.shade50, Colors.blue.shade100],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    themeProvider.getText('statistics'),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.blue.shade800),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            themeProvider.getText('total'),
                            style: TextStyle(
                                fontSize: 16,
                                color: themeProvider.isDarkMode
                                    ? Colors.white
                                    : Colors.blue.shade700),
                          ),
                          const SizedBox(height: 4),
                          Text('${tareasProvider.totalTareas}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Colors.blue.shade800)),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            themeProvider.getText('completed'),
                            style: TextStyle(
                                fontSize: 16,
                                color: themeProvider.isDarkMode
                                    ? Colors.white
                                    : Colors.blue.shade700),
                          ),
                          const SizedBox(height: 4),
                          Text('${tareasProvider.tareasCompletadas}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Colors.blue.shade800)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: LinearProgressIndicator(
                      value: tareasProvider.progreso,
                      minHeight: 8,
                      backgroundColor: themeProvider.isDarkMode
                          ? Colors.grey[700]
                          : Colors.blue.shade100,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        themeProvider.isDarkMode ? Colors.white : Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${themeProvider.getText('progress')}: ${(tareasProvider.progreso * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                        fontSize: 16,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.blue.shade700),
                  ),
                ],
              ),
            ),
          ),

          // Lista
          Expanded(
            child: tareasProvider.tareas.isEmpty
                ? Center(
                    child: Text(
                      themeProvider.getText('noTasks'),
                      style: TextStyle(
                          fontSize: 18,
                          color: themeProvider.isDarkMode
                              ? Colors.white70
                              : Colors.blueGrey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: tareasProvider.tareas.length,
                    itemBuilder: (_, i) =>
                        _buildTaskCard(context, tareasProvider.tareas[i]),
                  ),
          ),

          // Controles fijos
          Container(
            color: themeProvider.isDarkMode ? Colors.black87 : Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      themeProvider.isDarkMode
                          ? themeProvider.getText('dark')
                          : themeProvider.getText('light'),
                      style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.white
                              : Colors.black),
                    ),
                    Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (val) => themeProvider.toggleTheme(val),
                    ),
                  ],
                ),
                DropdownButton<String>(
                  value: themeProvider.language,
                  dropdownColor: themeProvider.isDarkMode
                      ? Colors.grey[900]
                      : Colors.white,
                  style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black),
                  items: const [
                    DropdownMenuItem(value: 'es', child: Text('Español')),
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    DropdownMenuItem(value: 'fr', child: Text('Français')),
                  ],
                  onChanged: (val) {
                    if (val != null) themeProvider.changeLanguage(val);
                  },
                ),
                ElevatedButton(
                  onPressed: () => themeProvider.savePreferences(),
                  child: Text(themeProvider.getText('savePrefs')),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
        onPressed: () => _mostrarDialogoAgregar(context),
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: themeProvider.isDarkMode
                ? [Colors.black87, Colors.black54]
                : [Colors.blue.shade800, Colors.blue.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Text(
            '© 2025 Keury Ramirez',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
