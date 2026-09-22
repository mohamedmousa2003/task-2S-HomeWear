import '../values/app_strings.dart';

abstract class Validator {
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.emptyField;
    }
    return null;
  }

  ///? Email Validator
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.emailRequired;
    }
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!emailRegex.hasMatch(value)) {
      return AppStrings.emailInvalid;
    }
    return null;
  }

  ///? Password Validator
  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.passwordRequired;
    }
    if (value.length < 6) {
      return AppStrings.passwordTooShort;
    }

    // يسمح بالحروف (كبيرة وصغيرة) والأرقام والرموز بشرط تحتوي على حروف وأرقام
    final passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)');
    if (!passwordRegex.hasMatch(value)) {
      return AppStrings.passwordValid;
    }

    return null;
  }

}
