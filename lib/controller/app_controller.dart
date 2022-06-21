import 'package:flutter/cupertino.dart';

class AppController extends ChangeNotifier {
  static AppController instance = AppController();
  bool isDarkTheme = true;
  changeThema() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }
}
