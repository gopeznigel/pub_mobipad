import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobipad/features/todo/ui/widget/todo_tile.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem(
      {Key key,
      this.todoItem,
      this.todoDone,
      this.deleteItem,
      this.toggleItem,
      this.fontSize,
      this.editing,
      this.editItem})
      : super(key: key);

  final String todoItem;
  final bool todoDone;
  final Function deleteItem;
  final Function toggleItem;
  final Function editItem;
  final bool editing;
  final int fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
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
            fontSize: fontSize.sp,
          ),
        ),
        trailing: Visibility(
          visible: editing,
          maintainState: true,
          maintainAnimation: true,
          maintainSize: true,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
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
