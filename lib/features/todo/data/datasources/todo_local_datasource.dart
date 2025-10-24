import '../models/todo_model.dart';

class TodoLocalDataSource {
  final List<TodoModel> _todos = [];

  List<TodoModel> getTodos() {
    return List.unmodifiable(_todos);
  }

  void addTodo(TodoModel todo) {
    _todos.add(todo);
  }

  void updateTodo(TodoModel todo) {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((t) => t.id == id);
  }

  TodoModel? getTodoById(String id) {
    try {
      return _todos.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }
}