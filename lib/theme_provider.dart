import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  String _themeMode = 'dark';
  String _colorScheme = 'gold';

  ThemeProvider() {
    _loadSettings();
  }

  String get themeMode => _themeMode;
  String get colorScheme => _colorScheme;

  void setTheme(String mode, String color) {
    _themeMode = mode;
    _colorScheme = color;
    _saveSettings();
    notifyListeners();
  }

  Color get primaryColor {
    switch (_colorScheme) {
      case 'default':
        return Color(0xFFD3C0A6);
      case 'purple':
        return Colors.purple;
      case 'orange':
        return Colors.orange;
      case 'teal':
        return Colors.teal;
      case 'gold':
      default:
        return Color(0xFFD4AF37);
    }
  }

  ThemeData get themeData {
    Color bgColor;
    Color textColor;
    Color appBarColor;
    if (_themeMode == 'light') {
      bgColor = Colors.white;
      textColor = Colors.black;
      appBarColor = primaryColor;
    } else {
      // dark
      bgColor = Color(0xFF121212); // dark gray instead of pure black
      textColor = Colors.white;
      appBarColor = Color(0xFF1E1E1E); // slightly lighter dark
    }

    return ThemeData(
      brightness: Brightness.light, // since we handle manually
      primaryColor: primaryColor,
      scaffoldBackgroundColor: bgColor,
      appBarTheme: AppBarTheme(
        backgroundColor: appBarColor,
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: textColor),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: bgColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: textColor,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: _themeMode == 'light' ? Colors.white : Colors.black,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
        titleLarge: TextStyle(color: textColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: textColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: textColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
    );
  }

  void _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _themeMode = prefs.getString('themeMode') ?? 'dark';
    _colorScheme = prefs.getString('colorScheme') ?? 'gold';
    notifyListeners();
  }

  void _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', _themeMode);
    prefs.setString('colorScheme', _colorScheme);
  }
}
