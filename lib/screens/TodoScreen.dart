import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/controllers/TodoController.dart';
import 'package:getx_todo/models/Todo.dart';

class TodoScreen extends StatelessWidget {
  final TodoController todoController = Get.find();
  final int index;

  TodoScreen({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = '';
    if (!index.isNull) {
      text = todoController.todos[index].text;
    }
    TextEditingController textEditingController =
        TextEditingController(text: text);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  autofocus: true,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: 'What do you want to do?',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 25),
                  keyboardType: TextInputType.multiline,
                  maxLines: 999,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Cancel'),
                    color: Colors.red,
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (index.isNull) {
                        todoController.todos.add(
                          Todo(text: textEditingController.text),
                        );
                      } else {
                        var editing = todoController.todos[index];
                        editing.text = textEditingController.text;
                        todoController.todos[index] = editing;
                      }

                      Get.back();
                    },
                    child: Text(index.isNull ? 'Add' : 'Edit'),
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
