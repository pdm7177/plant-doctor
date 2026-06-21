import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import 'app_strings.dart';

class LocaleProvider extends ChangeNotifier {
  String _languageCode = 'uk';
  final _storage = StorageService();

  String get languageCode => _languageCode;
  AppStrings get strings => AppStrings(_languageCode);

  Future<void> load() async {
    _languageCode = await _storage.loadLanguage();
    notifyListeners();
  }

  Future<void> setLanguage(String code) async {
    if (_languageCode == code) return;
    _languageCode = code;
    await _storage.saveLanguage(code);
    notifyListeners();
  }
}
