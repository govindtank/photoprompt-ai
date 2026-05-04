import 'package:flutter/material.dart';
import '../core/config/constants.dart';
import '../features/splash/screens/splash_screen.dart';
import '../features/home/screens/generation_screen.dart';
import '../features/gallery/screens/gallery_screen.dart';
import '../features/prompts/screens/prompts_list_screen.dart';
import '../features/prompts/screens/prompts_gallery_screen.dart';

/// Root widget for PhotoPrompt AI application
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initialize();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle app lifecycle events here if needed
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _initialize() async {
    try {
      await Hive.initFlutter();
      
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      print('Initialization error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      // Theme configuration
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: Constants.primaryColor,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        cardColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF6C63FF),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.black),
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
        ),
      ),
      
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: Constants.primaryColor,
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF121212),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Color(0xFFB0B0B0)),
          bodyMedium: TextStyle(color: Color(0xFF909090)),
        ),
      ),
      
      themeMode: ThemeMode.dark, // Force dark mode for photo viewing
      
      // Home route with splash screen
      home: const GenerationScreen(),
      
      // Route navigation
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/generation':
            return MaterialPageRoute(
              builder: (context) => const GenerationScreen(),
            );
          
          case '/gallery':
            return MaterialPageRoute(
              builder: (context) => const GalleryScreen(),
            );
          
          case '/prompts-list':
            return MaterialPageRoute(
              builder: (context) => const PromptsListScreen(),
            );
          
          case '/prompts-gallery':
            return MaterialPageRoute(
              builder: (context) => const PromptsGalleryScreen(),
            );
          
          default:
            return MaterialPageRoute(
              builder: (context) => const GenerationScreen(),
            );
        }
      },

      // Future features: Splash screen before main app
      initialRoute: '/',
      
      // Add custom configuration for responsive layout
      builder: (context, child) {
        if (child == null) return const SizedBox();
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).padding.left,
              right: MediaQuery.of(context).padding.right,
            ),
          ),
          child: child,
        );
      },
    );
  }
}
