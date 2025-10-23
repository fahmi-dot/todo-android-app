import 'package:flutter/material.dart';
import '../../features/todo/presentation/screens/todo_list_screen.dart';

class AppRouter {
  static const String todoList = '/';
  
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case todoList:
        return MaterialPageRoute(
          builder: (_) => const TodoListScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}