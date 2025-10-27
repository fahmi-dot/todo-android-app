import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../providers/todo_filter_provider.dart';

class FilterChips extends ConsumerWidget {
  const FilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(todoFilterProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingM,
        vertical: AppSizes.paddingS,
      ),
      child: Row(
        children: [
          _buildFilterChip(
            context,
            ref,
            label: AppStrings.filterAll,
            filter: TodoFilter.all,
            isSelected: currentFilter == TodoFilter.all,
          ),
          const SizedBox(width: AppSizes.paddingS),
          _buildFilterChip(
            context,
            ref,
            label: AppStrings.filterCompleted,
            filter: TodoFilter.completed,
            isSelected: currentFilter == TodoFilter.completed,
          ),
          const SizedBox(width: AppSizes.paddingS),
          _buildFilterChip(
            context,
            ref,
            label: AppStrings.filterUncompleted,
            filter: TodoFilter.uncompleted,
            isSelected: currentFilter == TodoFilter.uncompleted,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    WidgetRef ref, {
    required String label,
    required TodoFilter filter,
    required bool isSelected,
  }) {
    return FilterChip(
      label: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      selected: isSelected,
      onSelected: (_) {
        ref.read(todoFilterProvider.notifier).setFilter(filter);
      },
    );
  }
}
