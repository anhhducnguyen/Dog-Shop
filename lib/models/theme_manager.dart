import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  static const List<String> listColorAppBar = ['Blue', 'Green', 'Purple', 'Grey', 'White'];
  static const List<String> listBackGoundHomePage = ['Black', 'White'];
  static const List<String> listFontSize = ['Rất nhỏ', 'Nhỏ', 'Vừa', 'Lớn'];

  String _fontSize = 'Vừa'; // Changed the type to String
  String _appBarColor = 'White';
  String _backGoundHomePage = 'White';
  String _textColor = 'Black';

  String _selectedFontSize = 'Vừa';
  String get selectedAppBar => _selectedAppBar;
  String _selectedAppBar = 'White';
   
  set selectedFontSize(newSize) {
    _selectedFontSize = newSize;
    notifyListeners();
  }

  set selectedAppBar(newSize) {
    _selectedAppBar = newSize;
    notifyListeners();
  }

  set textColor(newColor) {
    _textColor = newColor;
    notifyListeners();
  }

  set appBarColor(newColor) {
    _appBarColor = newColor;
    notifyListeners();
  }

  set backGroundHomePage(newColor) {
    _backGoundHomePage = newColor;
    notifyListeners();
  }

  set fontSize(newSize) {
    _fontSize = newSize;
    notifyListeners();
  }

  double get fontSize {
  switch (_fontSize) {
    case 'Rất nhỏ':
      return 10;
    case 'Nhỏ':
      return 14;
    case 'Vừa':
      return 16;
    case 'Lớn':
      return 18;
    default:
      return 14;
  }
}

  Color get appBarColor {
    switch (_appBarColor) {
      case 'Blue':
        return Colors.blue.shade600;
      case 'Green':
        return Colors.green.shade600;
      case 'Purple':
        return Colors.purple.shade600;
      case 'Grey':
        return Colors.grey.shade600;
      case 'White':
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  Color get backGroundHomePage {
    switch (_backGoundHomePage) {
      case 'Black':
        return Colors.black;
      case 'White':
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  Color get textColor {
    if (_backGoundHomePage == 'Black') {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  String get strAppBarColor => _appBarColor;
  String get strBackGoundHomePage => _backGoundHomePage;
  String get strTextColor => _textColor;
  String get strFontSize => _fontSize;
  String get selectedFontSize => _selectedFontSize; 
  bool get isDarkMode => _themeMode == ThemeMode.dark;
}
