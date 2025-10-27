import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../data/datasources/todo_local_datasource.dart';
import '../../data/repositories/todo_repository_impl.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';

final todoLocalDataSourceProvider = Provider<TodoLocalDataSource>((ref) {
  return TodoLocalDataSource();
});

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  final dataSource = ref.read(todoLocalDataSourceProvider);
  return TodoRepositoryImpl(dataSource);
});

class TodoNotifier extends Notifier<List<Todo>> {
  final Uuid _uuid = const Uuid();

  @override
  List<Todo> build() {
    loadTodos();
    return [];
  }

  Future<void> loadTodos() async {
    final repository = ref.read(todoRepositoryProvider);
    final todos = await repository.getTodos();
    state = todos;
  }

  Future<void> addTodo(String title) async {
    final repository = ref.read(todoRepositoryProvider);
    final todo = Todo(
      id: _uuid.v4(),
      title: title.trim(),
      isCompleted: false,
      createdAt: DateTime.now(),
    );
    await repository.addTodo(todo);
    state = [...state, todo];
  }

  Future<void> updateTodo(String id, String newTitle) async {
    final repository = ref.read(todoRepositoryProvider);
    final todoIndex = state.indexWhere((t) => t.id == id);
    if (todoIndex != -1) {
      final updatedTodo = state[todoIndex].copyWith(title: newTitle.trim());
      await repository.updateTodo(updatedTodo);
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == todoIndex) updatedTodo else state[i],
      ];
    }
  }

  Future<void> toggleTodo(String id) async {
    final repository = ref.read(todoRepositoryProvider);
    await repository.toggleTodo(id);
    state = [
      for (final todo in state)
        if (todo.id == id)
          todo.copyWith(isCompleted: !todo.isCompleted)
        else
          todo,
    ];
  }

  Future<void> deleteTodo(String id) async {
    final repository = ref.read(todoRepositoryProvider);
    await repository.deleteTodo(id);
    state = state.where((t) => t.id != id).toList();
  }
}

final todoProvider = NotifierProvider<TodoNotifier, List<Todo>>(() {
  return TodoNotifier();
});