import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_todo/models/Todo.dart';

class TodoController extends GetxController {
  var todos = List<Todo>().obs;

  @override
  void onInit() {
    List storedTodos = GetStorage().read<List>('todos');
    if (!storedTodos.isNull) {
      todos = storedTodos.map((json) => Todo.fromJson(json)).toList().obs;
    }

    ever(todos, (_) {
      GetStorage().write('todos', todos.toList());
    });
    super.onInit();
  }
}
