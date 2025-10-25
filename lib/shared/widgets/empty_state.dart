// lib/shared/widgets/empty_state.dart
import 'package:flutter/material.dart';
import '../../core/constants/app_sizes.dart';

class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;

  const EmptyState({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: AppSizes.iconS * 5,
            color: const Color.fromRGBO(33, 33, 33, 0.2),
          ),
          const SizedBox(height: AppSizes.paddingL),
          Text(
            message,
            style: TextStyle(
              fontSize: AppSizes.fontL,
              color: const Color.fromRGBO(33, 33, 33, 0.4),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
