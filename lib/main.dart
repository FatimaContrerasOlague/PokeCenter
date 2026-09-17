import 'package:flutter/material.dart';
import 'package:poke_center/providers/poke_api_provider.dart';
import 'package:poke_center/screens/generation_list_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(
        create: (_) => PokeApiProvider(),
        lazy: false
      )
    ],
    child: MyApp(),
    );
  }
}

const _kPrimary = Color(0xFF5345AB);
const _kSecondary = Color(0xFFE5D36D);
const _kSurfaceVariant = Color(0xFFB8BDD5);
const _kDark = Color(0xFF1E2240);


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PokeCenter',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _kSurfaceVariant,
        colorScheme: const ColorScheme.dark(
          primary: _kPrimary,
          onPrimary: Colors.white,
          secondary: _kSecondary,
          onSecondary: _kDark,
          surface: _kSurfaceVariant,
          onSurface: _kDark

        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: _kPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        listTileTheme: const ListTileThemeData(
          tileColor:  Colors.white,
          textColor: _kDark,
          iconColor: _kPrimary,
        ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: _kSecondary,
            foregroundColor: _kDark
          ),

        ),
        home: const GenerationListScreen(),
      );
    }
  }
