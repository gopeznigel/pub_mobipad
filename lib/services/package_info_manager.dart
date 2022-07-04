import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoManager {
  static final PackageInfoManager _noteServiceService =
      PackageInfoManager._internal();

  factory PackageInfoManager() => _noteServiceService;

  PackageInfoManager._internal();

  PackageInfo? packageInfo;

  Future<void> init() async {
    packageInfo = await PackageInfo.fromPlatform();

    debugPrint('PackageInfo initialized');
  }

  String fullVersionNumber() {
    if (packageInfo == null) {
      return '';
    }

    var version = packageInfo!.version;
    var buildNumber = packageInfo!.buildNumber;

    return '$version+$buildNumber';
  }
}
