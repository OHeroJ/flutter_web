import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../themes/web_theme_data.dart';

class ThemeState extends ChangeNotifier {
  ThemeData get theme =>
      isDark ? WebThemeData.darkThemeData : WebThemeData.lightThemeData;
  bool _isDark;
  bool get isDark => _isDark;
  ThemeState({bool isDark = false}) : _isDark = isDark;
  void toggle() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
