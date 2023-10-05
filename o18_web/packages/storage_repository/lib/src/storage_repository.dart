import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class StorageRepository {
  static StorageRepository? _storageRepository;
  static late SharedPreferences? _preferences;

  static Future getInstance() async {
    log(
      'getting StorageService instance',
      name: 'StorageRepository',
    );

    if (_storageRepository == null) {
      // keep local instance till it is fully initialized.
      final secureStorage = StorageRepository._();
      await secureStorage._init();
      _storageRepository = secureStorage;
    }
    return _storageRepository;
  }

  StorageRepository._();
  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // get string
  static String getString(
    String key, {
    String defValue = '',
  }) =>
      _preferences!.getString(key) ?? defValue;

  // set string
  static Future setString(
    String key,
    String value,
  ) =>
      _preferences!.setString(key, value);

  // get int
  static int getInt(
    String key, {
    int defValue = 0,
  }) =>
      _preferences!.getInt(key) ?? defValue;

  // set int
  static Future setInt(
    String key,
    int value,
  ) =>
      _preferences!.setInt(key, value);

  // get bool
  static bool getBool(
    String key, {
    bool defValue = false,
  }) =>
      _preferences!.getBool(key) ?? defValue;

  // set bool
  static Future setBool({
    required String key,
    required bool value,
  }) =>
      _preferences!.setBool(key, value);

  static void clear() => _preferences!.clear();
}
