import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  final String _fontSizeKey = 'fontsize';
  final String _dateTimeDisplayKey = 'dateTimeDisplay';
  final String _sortKey = 'sort';

  Future<SharedPreferences> get _getSharedPrefInstance async =>
      await SharedPreferences.getInstance();

  // Functions for setting and getting fontSize value
  Future<bool> setFontSize(int value) async {
    var prefs = await _getSharedPrefInstance;
    return await prefs.setInt(_fontSizeKey, value);
  }

  Future<int?> get fontSize async {
    var prefs = await _getSharedPrefInstance;
    return prefs.getInt(_fontSizeKey);
  }

  // Functions for setting and getting date time display value
  Future<bool> setDateTimeDisplay(String value) async {
    var prefs = await _getSharedPrefInstance;
    return await prefs.setString(_dateTimeDisplayKey, value);
  }

  Future<String?> get dateTimeDisplay async {
    var prefs = await _getSharedPrefInstance;
    return prefs.getString(_dateTimeDisplayKey);
  }

  // Functions for setting and getting sort value
  Future<bool> setSort(String value) async {
    var prefs = await _getSharedPrefInstance;
    return await prefs.setString(_sortKey, value);
  }

  Future<String?> get sort async {
    var prefs = await _getSharedPrefInstance;
    return prefs.getString(_sortKey);
  }
}
