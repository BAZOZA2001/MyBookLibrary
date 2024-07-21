import 'package:flutter/material.dart';

enum SortOption {
  byTitle,
  byAuthor,
  byRating,
}

class SettingsProvider with ChangeNotifier {
  bool _isDarkMode = false;
  SortOption _sortOption = SortOption.byTitle; // Default sort option

  bool get isDarkMode => _isDarkMode;

  SortOption get sortOption => _sortOption;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setSortOption(SortOption option) {
    _sortOption = option;
    notifyListeners();
  }
}
