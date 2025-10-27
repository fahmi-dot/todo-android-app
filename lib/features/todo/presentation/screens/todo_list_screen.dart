import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../providers/todo_filter_provider.dart';
import '../providers/todo_provider.dart';
import '../widgets/filter_chips.dart';
import '../widgets/todo_form_dialog.dart';
import '../widgets/todo_item.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(filteredTodosProvider);
    final stats = ref.watch(todoStatsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.todoListTitle),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingM,
                ),
                child: Text(
                  '${stats['completed']}/${stats['total']} selesai',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: AppSizes.fontM,
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.paddingS),
              const FilterChips(),
            ],
          ),
        ),
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
                return TodoItem(todo: todos[index]);
              },
            ),
      floatingActionButton: CustomButton(
        type: ButtonType.primary,
        onPressed: () {
          TodoFormDialog.show(
            context,
            onSubmit: (title) {
              ref.read(todoProvider.notifier).addTodo(title);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(AppStrings.todoAdded),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          );
        },
        label: AppStrings.addTodoTitle,
        icon: Icons.add, 
      ),
    );
  }
}
