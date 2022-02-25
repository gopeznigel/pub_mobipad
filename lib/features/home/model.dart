class Note {
  final String id;
  final String title;
  final List<ToDoItem> todoList;
  final String description;
  final int dateCreated;
  final int dateModified;
  final int dateDeleted;
  final int dateArchived;
  final bool pinned;
  final Reminder reminder;

  Note(
      {this.id,
      this.title,
      this.description,
      this.todoList,
      this.dateCreated,
      this.dateModified,
      this.dateDeleted,
      this.dateArchived,
      this.pinned,
      this.reminder});

  factory Note.fromJson(Map<dynamic, dynamic> json, String id) =>
      _noteFromJson(json, id);

  Map<String, dynamic> toJson() => _noteToJson(this);
}

class ToDoItem {
  final String todo;
  final bool done;

  ToDoItem({this.todo, this.done});

  factory ToDoItem.fromJson(Map<dynamic, dynamic> json) =>
      _toDoItemFromJson(json);

  Map<String, dynamic> toJson() => _toDoItemToJson(this);
}

class Reminder {
  final int remId;
  final List<int> reminderStart;
  final List<Map<String, dynamic>> days;
  final int selectedRepeat;

  Reminder({this.remId, this.reminderStart, this.days, this.selectedRepeat});

  factory Reminder.fromJson(Map<dynamic, dynamic> json) =>
      _reminderFromJson(json);

  Map<String, dynamic> toJson() => _reminderToJson(this);
}

Note _noteFromJson(Map<dynamic, dynamic> json, String id) {
  return Note(
    id: id,
    title: json['title'] as String,
    description: json['description'] as String,
    todoList: _convertTodos(json['todoList'] as List),
    dateCreated: json['dateCreated'] as int,
    dateModified: json['dateModified'] as int,
    dateDeleted: json['dateDeleted'] as int,
    dateArchived: json['dateArchived'] as int,
    pinned: json['pinned'] as bool,
    reminder: _reminderFromJson(json['reminder']),
  );
}

List<ToDoItem> _convertTodos(List todoMap) {
  if (todoMap == null) {
    return null;
  }

  var todos = <ToDoItem>[];

  for (var element in todoMap) {
    todos.add(ToDoItem.fromJson(element));
  }

  return todos;
}

Map<String, dynamic> _noteToJson(Note instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'todoList': _todoList(instance.todoList),
      'dateCreated': instance.dateCreated,
      'dateModified': instance.dateModified,
      'dateDeleted': instance.dateDeleted,
      'dateArchived': instance.dateArchived,
      'pinned': instance.pinned,
      'reminder': _reminderToJson(instance.reminder),
    };

List<Map<String, dynamic>> _todoList(List<ToDoItem> todos) {
  if (todos == null) {
    return null;
  }

  var todoMap = <Map<String, dynamic>>[];
  for (var todo in todos) {
    todoMap.add(todo.toJson());
  }

  return todoMap;
}

ToDoItem _toDoItemFromJson(Map<dynamic, dynamic> json) {
  return ToDoItem(
    todo: json['todo'] as String,
    done: json['done'] as bool,
  );
}

Map<String, dynamic> _toDoItemToJson(ToDoItem instance) => <String, dynamic>{
      'todo': instance.todo,
      'done': instance.done,
    };

Reminder _reminderFromJson(Map<dynamic, dynamic> json) {
  if (json == null) {
    return null;
  }

  return Reminder(
    remId: json['remId'] as int,
    reminderStart: _reminderListFromJson(json['reminderStart']),
    days: _dayList(json['days']),
    selectedRepeat: json['selectedRepeat'] as int,
  );
}

List<int> _reminderListFromJson(List json) {
  if (json == null) {
    return null;
  }

  var reminderStart = <int>[];
  for (var element in json) {
    reminderStart.add(element as int);
  }

  return reminderStart;
}

Map<String, dynamic> _reminderToJson(Reminder instance) => <String, dynamic>{
      'remId': instance.remId,
      'reminderStart': instance.reminderStart,
      'days': instance.days,
      'selectedRepeat': instance.selectedRepeat,
    };

List<Map<String, dynamic>> _dayList(List days) {
  if (days == null) {
    return null;
  }

  var dayMap = <Map<String, dynamic>>[];
  for (var day in days) {
    dayMap.add({'name': day['name'], 'value': day['value']});
  }

  return dayMap;
}
