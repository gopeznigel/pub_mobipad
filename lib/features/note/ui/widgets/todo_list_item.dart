import 'package:flutter/material.dart';

import 'todo_tile.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    Key? key,
    required this.todoItem,
    required this.todoDone,
    required this.deleteItem,
    required this.toggleItem,
    required this.editing,
    required this.editItem,
    required this.fontSize,
  }) : super(key: key);

  final String todoItem;
  final bool todoDone;
  final Function deleteItem;
  final Function toggleItem;
  final Function editItem;
  final bool editing;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.2),
        ),
      ),
      child: TodoTile(
        onTap: () {
          if (!editing) {
            toggleItem();
          } else {
            editItem();
          }
        },
        leading: todoDone
            ? Icon(
                Icons.check_circle_outline,
                color: editing ? Colors.grey : Theme.of(context).primaryColor,
              )
            : Icon(
                Icons.panorama_fish_eye,
                color: editing ? Colors.grey : Colors.black54,
              ),
        title: Text(
          todoItem,
          style: TextStyle(
            color: editing
                ? Colors.grey
                : todoDone
                    ? Colors.black54
                    : Colors.black,
            decoration:
                todoDone ? TextDecoration.lineThrough : TextDecoration.none,
            fontSize: fontSize,
          ),
        ),
        trailing: Visibility(
          visible: editing,
          maintainState: true,
          maintainAnimation: true,
          maintainSize: true,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
            onPressed: () {
              deleteItem();
            },
          ),
        ),
      ),
    );
  }
}
