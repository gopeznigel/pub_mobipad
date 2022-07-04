import 'package:flutter/foundation.dart';

@immutable
class SetFontSize {
  const SetFontSize(this.fontSize);

  final int fontSize;

  @override
  String toString() => 'SetFontSize {fontSize: $fontSize}';
}

@immutable
class LoadFontSize {
  const LoadFontSize(this.fontSize);

  final int fontSize;

  @override
  String toString() => 'LoadFontSize {fontSize: $fontSize}';
}

@immutable
class SetSort {
  const SetSort(this.sort);

  final String sort;

  @override
  String toString() => 'SetSort {sort: $sort}';
}

@immutable
class LoadSort {
  const LoadSort(this.sort);

  final String sort;

  @override
  String toString() => 'LoadSort {sort: $sort}';
}

@immutable
class SetDateTimeDisplay {
  const SetDateTimeDisplay(this.display);

  final String display;

  @override
  String toString() => 'SetDateTimeDisplay {display: $display}';
}

@immutable
class LoadDateTimeDisplay {
  const LoadDateTimeDisplay(this.display);

  final String display;

  @override
  String toString() => 'LoadDateTimeDisplay {display: $display}';
}
