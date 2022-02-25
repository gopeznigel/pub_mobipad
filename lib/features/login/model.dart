import 'package:flutter/foundation.dart';

class OhNotesUser {
  String userId;
  String email;

  OhNotesUser({@required this.userId, @required this.email});

  factory OhNotesUser.fromJson(Map<dynamic, dynamic> json, String id) =>
      _noteFromJson(json, id);

  Map<String, dynamic> toJson() => _userToJson(this);
}

OhNotesUser _noteFromJson(Map<dynamic, dynamic> json, String userId) {
  return OhNotesUser(
    userId: userId,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _userToJson(OhNotesUser instance) => <String, dynamic>{
      'email': instance.email,
    };
