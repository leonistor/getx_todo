import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/controllers/TodoController.dart';
import 'package:getx_todo/screens/TodoScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.put(TodoController());

    return Scaffold(
      appBar: AppBar(title: Text('GetX Todo List')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(TodoScreen());
        },
      ),
      body: SafeArea(
        child: Container(
          child: Obx(
            () => ListView.separated(
              itemBuilder: (context, index) {
                var todo = todoController.todos[index];
                return ListTile(
                  title: Text(
                    todo.text,
                    style: todo.done
                        ? TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                          )
                        : TextStyle(color: Get.theme.textTheme.bodyText1.color),
                  ),
                  onTap: () {
                    Get.to(TodoScreen(index: index));
                  },
                  leading: Checkbox(
                    value: todo.done,
                    onChanged: (value) {
                      todo.done = value;
                      // notify controller!
                      todoController.todos[index] = todo;
                    },
                  ),
                  trailing: Icon(Icons.chevron_right),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: todoController.todos.length,
            ),
          ),
        ),
      ),
    );
  }
}
