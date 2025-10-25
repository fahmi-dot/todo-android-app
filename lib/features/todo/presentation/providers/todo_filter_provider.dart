import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/todo.dart';
import 'todo_provider.dart';

enum TodoFilter { all, completed, uncompleted }

class TodoFilterNotifier extends Notifier<TodoFilter> {
  @override
  TodoFilter build() {
    return TodoFilter.all;
  }

  void setFilter(TodoFilter filter) {
    state = filter;
  }
}

final todoFilterProvider = NotifierProvider<TodoFilterNotifier, TodoFilter>(() {
  return TodoFilterNotifier();
});

final filteredTodosProvider = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoFilterProvider);
  final todos = ref.watch(todoProvider);

  switch (filter) {
    case TodoFilter.completed:
      return todos.where((todo) => todo.isCompleted).toList();
    case TodoFilter.uncompleted:
      return todos.where((todo) => !todo.isCompleted).toList();
    case TodoFilter.all:
    return todos;
  }
});

// Todo Stats Provider
final todoStatsProvider = Provider<Map<String, int>>((ref) {
  final todos = ref.watch(todoProvider);
  final completed = todos.where((todo) => todo.isCompleted).length;
  final uncompleted = todos.length - completed;

  return {
    'total': todos.length,
    'completed': completed,
    'uncompleted': uncompleted,
  };
});
