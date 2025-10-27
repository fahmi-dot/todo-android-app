import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo_model.dart';

class TodoLocalDataSource {
  static const _key = 'todos';

  Future<List<TodoModel>> getTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];
    final List list = jsonDecode(jsonString);
    return list.map((e) => TodoModel.fromJson(e)).toList();
  }

  Future<void> saveTodos(List<TodoModel> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = todos.map((e) => e.toJson()).toList();
    await prefs.setString(_key, jsonEncode(jsonList));
  }

  Future<void> addTodo(TodoModel todo) async {
    final todos = await getTodos();
    todos.add(todo);
    await saveTodos(todos);
  }

  Future<void> updateTodo(TodoModel todo) async {
    final todos = await getTodos();
    final index = todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      todos[index] = todo;
      await saveTodos(todos);
    }
  }

  Future<void> deleteTodo(String id) async {
    final todos = await getTodos();
    todos.removeWhere((t) => t.id == id);
    await saveTodos(todos);
  }

  Future<TodoModel?> getTodoById(String id) async {
    final todos = await getTodos();
    try {
      return todos.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }
}