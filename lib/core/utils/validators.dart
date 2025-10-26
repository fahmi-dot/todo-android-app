import '../constants/app_strings.dart';

class Validators {
  static String? validateTodo(String? value) {
    if (!isNotEmpty(value!)) {
      return AppStrings.emptyTodoError;
    }
    if (value.trim().length < 3) {
      return "Tugas minimal 3 karakter";
    }
    return null;
  }

  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }
}