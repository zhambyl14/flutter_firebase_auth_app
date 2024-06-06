import 'package:flutter/material.dart';
import 'themes.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _currentTheme = lightTheme;

  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    if (_currentTheme == lightTheme) {
      _currentTheme = darkTheme;
    } else if (_currentTheme == darkTheme) {
      _currentTheme = purpleTheme;
    } else {
      _currentTheme = lightTheme;
    }
    notifyListeners();
  }

  void toggleThemeToLight() {
    _currentTheme = lightTheme;
    notifyListeners();
  }

  void toggleThemeToDark() {
    _currentTheme = darkTheme;
    notifyListeners();
  }

  void toggleThemeToPurple() {
    _currentTheme = purpleTheme;
    notifyListeners();
  }
}
