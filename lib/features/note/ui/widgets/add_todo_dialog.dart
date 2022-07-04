import 'package:flutter/material.dart';
import 'package:mobipad/styles/text_styles.dart';

typedef AddTodoFunc = void Function(String);
typedef EditTodoFunc = void Function(String);

class AddTodoDialog extends StatelessWidget {
  const AddTodoDialog({
    Key? key,
    this.onAddTodo,
    this.onEditTodo,
    this.todo,
  }) : super(key: key);

  final AddTodoFunc? onAddTodo;
  final EditTodoFunc? onEditTodo;
  final String? todo;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: todo);

    return Dialog(
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        width: 500,
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: TextFormField(
                  autofocus: true,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'What do you need to do?',
                    hintStyle: OhNotesTextStyles.notePreviewBody.copyWith(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                  style: OhNotesTextStyles.notePreviewBody.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (controller.text.isEmpty) return;

                      if (onAddTodo != null) {
                        onAddTodo!(controller.text);
                      } else if (onEditTodo != null) {
                        onEditTodo!(controller.text);
                      }

                      controller.clear();
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey),
                          right: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          todo == null ? 'Save' : 'OK',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (controller.text.isEmpty) return;

                      if (onAddTodo != null) {
                        onAddTodo!(controller.text);
                      }

                      controller.clear();

                      if (onEditTodo != null) {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          todo == null ? 'Next' : 'Cancel',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
