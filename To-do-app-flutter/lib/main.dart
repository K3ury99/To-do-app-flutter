import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/tareas_provider.dart';
import 'providers/theme_provider.dart';
import 'views/tareas_screen.dart';

void main() {
  runApp(const AppInitializer());
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  final themeProvider = ThemeProvider();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    themeProvider.loadPreferences().then((_) {
      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
        ChangeNotifierProvider(create: (_) => TareasProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Lista de Tareas - Kortex',
            theme: ThemeData(
              brightness: theme.isDarkMode ? Brightness.dark : Brightness.light,
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor:
                  theme.isDarkMode ? Colors.black : Colors.grey[100],
              appBarTheme: AppBarTheme(
                backgroundColor: theme.isDarkMode ? Colors.black : Colors.blue,
                foregroundColor: Colors.white,
              ),
              colorScheme: theme.isDarkMode
                  ? ColorScheme.dark().copyWith(secondary: Colors.grey)
                  : ColorScheme.light().copyWith(secondary: Colors.blueAccent),
            ),
            home: const TareasScreen(),
          );
        },
      ),
    );
  }
}
