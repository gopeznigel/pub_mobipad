import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dtos.g.dart';

class SelectionModeEnum extends EnumClass {
  const SelectionModeEnum._(String name) : super(name);

  static const SelectionModeEnum none = _$none;
  static const SelectionModeEnum multiple = _$multiple;

  static Serializer<SelectionModeEnum> get serializer =>
      _$selectionModeEnumSerializer;
  static BuiltSet<SelectionModeEnum> get values => _$selectionModeEnumValues;
  static SelectionModeEnum valueOf(String name) =>
      _$selectionModeEnumValueOf(name);
}

extension SelectionModeEnumX on SelectionModeEnum {
  bool get isNone => this == SelectionModeEnum.none;
  bool get isMultiple => this == SelectionModeEnum.multiple;
}

class MultiPinEnum extends EnumClass {
  const MultiPinEnum._(String name) : super(name);

  static const MultiPinEnum disabled = _$disabled;
  static const MultiPinEnum multiPin = _$multiPin;
  static const MultiPinEnum multiUnpin = _$multiUnpin;

  static Serializer<MultiPinEnum> get serializer => _$multiPinEnumSerializer;
  static BuiltSet<MultiPinEnum> get values => _$multiPinEnumValues;
  static MultiPinEnum valueOf(String name) => _$multiPinEnumValueOf(name);
}

extension MultiPinEnumX on MultiPinEnum {
  bool get isDsabled => this == MultiPinEnum.disabled;
  bool get isMultiPin => this == MultiPinEnum.multiPin;
  bool get isMultiUnPin => this == MultiPinEnum.multiUnpin;
}
