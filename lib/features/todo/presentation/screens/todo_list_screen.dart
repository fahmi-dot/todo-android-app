import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../providers/todo_filter_provider.dart';
import '../widgets/todo_form_dialog.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(filteredTodosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.todoListTitle),
      ),
      body: todos.isEmpty
          ? const EmptyState(
              message: AppStrings.emptyTodoMessage,
              icon: Icons.warning_rounded,
            )
          : ListView.builder(
              padding: const EdgeInsets.only(
                top: AppSizes.paddingM,
                bottom: AppSizes.paddingXL * 2,
              ),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return Text(index.toString());
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          TodoFormDialog.show(
            context,
            onSubmit: (title) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(AppStrings.todoAdded),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          );
        },
        icon: const Icon(Icons.add),
        label: const Text(AppStrings.addTodoTitle),
      ),
    );
  }
}