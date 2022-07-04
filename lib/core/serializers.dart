import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'dtos.dart';

part 'serializers.g.dart';

@SerializersFor([
  NoteDto,
  TodoDto,
  ReminderDto,
  ReminderDayDto,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
