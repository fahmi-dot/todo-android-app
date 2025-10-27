import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_datasource.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource _localDataSource;

  TodoRepositoryImpl(this._localDataSource);

  @override
  List<Todo> getTodos() {
    return _localDataSource.getTodos();
  }

  @override
  void addTodo(Todo todo) {
    final model = TodoModel.fromEntity(todo);
    _localDataSource.addTodo(model);
  }

  @override
  void updateTodo(Todo todo) {
    final model = TodoModel.fromEntity(todo);
    _localDataSource.updateTodo(model);
  }

  @override
  void deleteTodo(String id) {
    _localDataSource.deleteTodo(id);
  }

  @override
  void toggleTodo(String id) {
    final todo = _localDataSource.getTodoById(id);
    if (todo != null) {
      final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
      final updatedTodoModel = TodoModel.fromEntity(updatedTodo);
      _localDataSource.updateTodo(updatedTodoModel);
    }
  }
}