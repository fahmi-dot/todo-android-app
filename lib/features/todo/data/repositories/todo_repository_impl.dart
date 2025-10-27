import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_datasource.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource _localDataSource;

  TodoRepositoryImpl(this._localDataSource);

  @override
  Future<List<Todo>> getTodos() async {
    return await _localDataSource.getTodos();
  }

  @override
  Future<void> addTodo(Todo todo) async {
    final model = TodoModel.fromEntity(todo);
    await _localDataSource.addTodo(model);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final model = TodoModel.fromEntity(todo);
    await _localDataSource.updateTodo(model);
  }

  @override
  Future<void> deleteTodo(String id) async {
    await _localDataSource.deleteTodo(id);
  }

  @override
  Future<void> toggleTodo(String id) async {
    final todo = await _localDataSource.getTodoById(id);
    if (todo == null) return;
    final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
    final updatedTodoModel = TodoModel.fromEntity(updatedTodo);
    await _localDataSource.updateTodo(updatedTodoModel);
  }
}
