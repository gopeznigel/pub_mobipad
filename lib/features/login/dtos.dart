import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dtos.g.dart';

abstract class UserDto implements Built<UserDto, UserDtoBuilder> {
  factory UserDto([void Function(UserDtoBuilder b) updates]) = _$UserDto;

  UserDto._();

  static Serializer<UserDto> get serializer => _$userDtoSerializer;

  String get userId;
  String? get email;
}

class LoginStatusEnum extends EnumClass {
  const LoginStatusEnum._(String name) : super(name);

  static const LoginStatusEnum initial = _$initial;
  static const LoginStatusEnum loading = _$loading;
  static const LoginStatusEnum done = _$done;

  static Serializer<LoginStatusEnum> get serializer =>
      _$loginStatusEnumSerializer;
  static BuiltSet<LoginStatusEnum> get values => _$loginStatusEnumValues;
  static LoginStatusEnum valueOf(String name) => _$loginStatusEnumValueOf(name);
}

extension LoginStatusEnumX on LoginStatusEnum {
  bool get isInitial => this == LoginStatusEnum.initial;
  bool get isLoading => this == LoginStatusEnum.loading;
  bool get isDone => this == LoginStatusEnum.done;
}
