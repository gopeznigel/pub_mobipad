import 'package:mobipad/services/settings_repository.dart';

class SettingsApi {
  late final SettingsRepository _repo;

  SettingsApi(this._repo);

  Future<bool> setFontSize(int value) async {
    return await _repo.setFontSize(value);
  }

  Future<bool> setDateTimeDisplay(String value) async {
    return await _repo.setDateTimeDisplay(value);
  }

  Future<bool> setSort(String value) async {
    return await _repo.setSort(value);
  }

  Future<int?> getFontSize() async => await _repo.fontSize;

  Future<String?> getDateTimeDisplay() async => await _repo.dateTimeDisplay;

  Future<String?> getSort() async => await _repo.sort;
}
