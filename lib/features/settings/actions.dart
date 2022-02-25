import 'package:flutter/foundation.dart';
import 'package:mobipad/exception/action_exception.dart';

@immutable
class SetFontSize {
  SetFontSize(this.fontSize) : assert(fontSize != null);

  final int fontSize;

  @override
  String toString() => 'SetFontSize {fontSize: $fontSize}';
}

@immutable
class SetFontSizeSucceeded {
  @override
  String toString() => 'SetFontSizeSucceeded';
}

@immutable
class SetFontSizeFailed {
  SetFontSizeFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'SetFontSizeFailed {exception: $exception}';
}

@immutable
class GetFontSize {
  @override
  String toString() => 'GetFontSize';
}

@immutable
class GetFontSizeSucceeded {
  GetFontSizeSucceeded(this.fontSize) : assert(fontSize != null);

  final int fontSize;

  @override
  String toString() => 'GetFontSizeSucceeded {fontSize: $fontSize}';
}

@immutable
class GetFontSizeFailed {
  GetFontSizeFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'GetFontSizeFailed {exception: $exception}';
}

@immutable
class SortNotes {
  SortNotes(this.sortBy) : assert(sortBy != null);

  final String sortBy;

  @override
  String toString() => 'SortNotes {sortBy: $sortBy}';
}

@immutable
class UpdateSorting {
  UpdateSorting(this.sortBy) : assert(sortBy != null);

  final String sortBy;

  @override
  String toString() => 'UpdateSorting {sortBy: $sortBy}';
}

@immutable
class SetDateTimeDisplay {
  SetDateTimeDisplay(this.display) : assert(display != null);

  final String display;

  @override
  String toString() => 'SetDateTimeDisplay {display: $display}';
}

@immutable
class SetDateTimeDisplaySucceeded {
  @override
  String toString() => 'SetDateTimeDisplaySucceeded';
}

@immutable
class SetDateTimeDisplayFailed {
  SetDateTimeDisplayFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'SetDateTimeDisplayFailed {exception: $exception}';
}

@immutable
class GetDateTimeDisplay {
  @override
  String toString() => 'GetDateTimeDisplay';
}

@immutable
class GetDateTimeDisplaySucceeded {
  GetDateTimeDisplaySucceeded(this.display) : assert(display != null);

  final String display;

  @override
  String toString() => 'GetDateTimeDisplaySucceeded {display: $display}';
}

@immutable
class GetDateTimeDisplayFailed {
  GetDateTimeDisplayFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'GetDateTimeDisplayFailed {exception: $exception}';
}