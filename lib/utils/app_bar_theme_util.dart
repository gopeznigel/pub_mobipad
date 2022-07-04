import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../core/dtos.dart';

class AppBarThemeUtil {
  static Color getAppBarColor(NoteCategoryEnum cat) {
    switch (cat) {
      case NoteCategoryEnum.active:
        return OhNotesColor.primary;
      case NoteCategoryEnum.archived:
        return OhNotesColor.archive;
      case NoteCategoryEnum.trashed:
        return OhNotesColor.trash;
      default:
        return OhNotesColor.primary;
    }
  }
}
