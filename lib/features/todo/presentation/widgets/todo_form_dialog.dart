import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/custom_button.dart';

class TodoFormDialog extends StatefulWidget {
  final bool isEdit;
  final String? initialTitle;
  final Function(String) onSubmit;

  const TodoFormDialog({
    super.key,
    required this.isEdit,
    this.initialTitle,
    required this.onSubmit,
  });

  static Future<void> show(
    BuildContext context, {
    bool isEdit = false,
    String? initialTitle,
    required Function(String) onSubmit,
  }) {
    return showDialog(
      context: context,
      builder: (context) => TodoFormDialog(
        isEdit: isEdit,
        initialTitle: initialTitle,
        onSubmit: onSubmit,
      ),
    );
  }

  @override
  State<TodoFormDialog> createState() => _TodoFormDialogState();
}

class _TodoFormDialogState extends State<TodoFormDialog> {
  late final TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialTitle);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_controller.text);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.isEdit ? AppStrings.editTodoTitle : AppStrings.addTodoTitle,
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Masukkan tugas...",
            contentPadding: EdgeInsets.all(AppSizes.paddingM),
          ),
          validator: Validators.validateTodo,
          onFieldSubmitted: (_) => _submit(),
        ),
      ),
      actions: [
        CustomButton(
          type: ButtonType.text,
          onPressed: () => Navigator.of(context).pop(),
          label: AppStrings.cancel,
        ),
        CustomButton(
          type: ButtonType.primary,
          onPressed: _submit,
          label:  widget.isEdit ? AppStrings.save : AppStrings.addTodoTitle,
        ),
      ],
    );
  }
}