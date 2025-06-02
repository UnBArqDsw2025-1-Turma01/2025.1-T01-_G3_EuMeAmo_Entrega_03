// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Import for localization delegates
import 'package:intl/date_symbol_data_local.dart'; // Import for date formatting initialization

import 'package:provider/provider.dart'; // Import Provider

// Import your screens
import 'views/auth/login_screen.dart';
import 'views/auth/cadastro_aluno_screen.dart';
import 'views/auth/cadastro_especialista_screen.dart';
import 'views/auth/recuperar_senha_screen.dart';
import 'views/home/dashboard_screen.dart';
import 'views/especialista/catalogo_profissionais_screen.dart';
import 'views/treino/ficha_treino_screen.dart';
import 'views/alimentacao/ficha_dieta_screen.dart';
import 'views/desafio/desafio_diario_screen.dart';
import 'views/relatorio/relatorio_atividades_screen.dart';
import 'views/calendario/calendario_screen.dart'; // <-- Import the new Calendar screen
import 'views/comunidade/comunidade_screen.dart'; // <-- Import the Community screen
import 'views/settings/settings_screen.dart'; // <-- Import the Settings screen
import 'views/help/help_screen.dart'; // <-- Import the Help screen

// Import your controllers if needed for initialization (dependency injection)
import 'controllers/comunidade_controller.dart'; // Import ComunidadeController

void main() async { // Make main async
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize date formatting for the 'pt_BR' locale.
  // Need to await this before running the app.
  await initializeDateFormatting('pt_BR', null);

  runApp(
    ChangeNotifierProvider(
      create: (context) => ComunidadeController(), // Provide the controller
      child: const EuMeAmoApp(),
    ),
  );
}

class EuMeAmoApp extends StatelessWidget {
  const EuMeAmoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EuMeAmo App',
      theme: ThemeData(
        primarySwatch: Colors.red, // Or create a custom theme based on prototype colors
        // Define primary colors based on prototype
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB74C4C), // Primary Red
          primary: const Color(0xFFB74C4C),
          secondary: const Color(0xFF8DC63F), // Green Accent
          background: const Color(0xFFFDF3E7), // Light Beige
          surface: const Color(0xFFFFF9F2), // Card Beige
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onBackground: const Color(0xFF4D342F), // Dark Brown
          onSurface: const Color(0xFF4D342F),
        ),
        scaffoldBackgroundColor: const Color(0xFFFDF3E7),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: const Color(0xFFFFF9F2), // Default card background
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFB74C4C), width: 2),
          ),
          labelStyle: const TextStyle(color: Color(0xFF4D342F)),
          hintStyle: TextStyle(color: Colors.grey.shade500),
          prefixIconColor: Colors.grey.shade500,
        ),
        // Define other theme properties like text themes, button themes etc.
        fontFamily: 'Roboto', // Example: Use a specific font if needed
      ),
      // Localization support
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'), // Portuguese, Brazil
        // Add other locales your app supports
      ],
      locale: const Locale('pt', 'BR'), // Set default locale

      // Define the initial route
      initialRoute: '/login', // Start with the login screen

      // Define the routes for navigation
      routes: {
        '/login': (context) => const LoginScreen(),
        '/cadastro_aluno': (context) => const CadastroAlunoScreen(),
        '/cadastro_especialista': (context) => const CadastroEspecialistaScreen(),
        '/recuperar_senha': (context) => const RecuperarSenhaScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/catalogo_profissionais': (context) => const CatalogoProfissionaisScreen(),
        '/ficha_treino': (context) => const FichaTreinoScreen(),
        '/ficha_dieta': (context) => const FichaDietaScreen(),
        '/desafio_diario': (context) => const DesafioDiarioScreen(),
        '/relatorio_atividades': (context) => const RelatorioAtividadesScreen(),
        '/calendario': (context) => const CalendarioScreen(), // <-- Add the Calendar route
        '/comunidade': (context) => const ComunidadeScreen(), // <-- Add the Community route
        '/settings': (context) => const SettingsScreen(), // <-- Add the Settings route
        '/help': (context) => const HelpScreen(), // <-- Add the Help route
        // Add other routes here
      },
      // Optional: Define onGenerateRoute for dynamic routes or passing arguments
      // onGenerateRoute: (settings) { ... }

      // Optional: Define onUnknownRoute for handling undefined routes
      // onUnknownRoute: (settings) { ... }

      debugShowCheckedModeBanner: false, // Hide debug banner
    );
  }
}

