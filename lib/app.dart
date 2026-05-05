import 'package:flutter/material.dart';
import '../core/config/themes.dart';
import '../features/home/screens/generation_screen.dart';

/// Root widget for PhotoPrompt AI application
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PhotoPrompt AI',
      theme: Themes.darkTheme,
      darkTheme: Themes.darkTheme,
      themeMode: ThemeMode.dark,
      home: const GenerationScreen(),
    );
  }
}
