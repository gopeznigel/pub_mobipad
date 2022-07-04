// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dtos.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LoginStatusEnum _$initial = const LoginStatusEnum._('initial');
const LoginStatusEnum _$loading = const LoginStatusEnum._('loading');
const LoginStatusEnum _$done = const LoginStatusEnum._('done');

LoginStatusEnum _$loginStatusEnumValueOf(String name) {
  switch (name) {
    case 'initial':
      return _$initial;
    case 'loading':
      return _$loading;
    case 'done':
      return _$done;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<LoginStatusEnum> _$loginStatusEnumValues =
    new BuiltSet<LoginStatusEnum>(const <LoginStatusEnum>[
  _$initial,
  _$loading,
  _$done,
]);

Serializer<UserDto> _$userDtoSerializer = new _$UserDtoSerializer();
Serializer<LoginStatusEnum> _$loginStatusEnumSerializer =
    new _$LoginStatusEnumSerializer();

class _$UserDtoSerializer implements StructuredSerializer<UserDto> {
  @override
  final Iterable<Type> types = const [UserDto, _$UserDto];
  @override
  final String wireName = 'UserDto';

  @override
  Iterable<Object?> serialize(Serializers serializers, UserDto object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.email;
    if (value != null) {
      result
        ..add('email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  UserDto deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserDtoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$LoginStatusEnumSerializer
    implements PrimitiveSerializer<LoginStatusEnum> {
  @override
  final Iterable<Type> types = const <Type>[LoginStatusEnum];
  @override
  final String wireName = 'LoginStatusEnum';

  @override
  Object serialize(Serializers serializers, LoginStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  LoginStatusEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      LoginStatusEnum.valueOf(serialized as String);
}

class _$UserDto extends UserDto {
  @override
  final String userId;
  @override
  final String? email;

  factory _$UserDto([void Function(UserDtoBuilder)? updates]) =>
      (new UserDtoBuilder()..update(updates))._build();

  _$UserDto._({required this.userId, this.email}) : super._() {
    BuiltValueNullFieldError.checkNotNull(userId, r'UserDto', 'userId');
  }

  @override
  UserDto rebuild(void Function(UserDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserDtoBuilder toBuilder() => new UserDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserDto && userId == other.userId && email == other.email;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, userId.hashCode), email.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserDto')
          ..add('userId', userId)
          ..add('email', email))
        .toString();
  }
}

class UserDtoBuilder implements Builder<UserDto, UserDtoBuilder> {
  _$UserDto? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  UserDtoBuilder();

  UserDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserDto;
  }

  @override
  void update(void Function(UserDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserDto build() => _build();

  _$UserDto _build() {
    final _$result = _$v ??
        new _$UserDto._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'UserDto', 'userId'),
            email: email);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
