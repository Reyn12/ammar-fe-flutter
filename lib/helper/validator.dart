import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';


sealed class Validate {
  static FormFieldValidator<String> regex({
    required RegExp regex,
    required String err,
  }) {
    return (v) {
      if (v != null && regex.hasMatch(v)) {
        return null;
      } else {
        return err;
      }
    };
  }
}

class Validator {
  static FormFieldValidator<T> list<T>(List<FormFieldValidator<T>> validators) {
    return (valueCandidate) {
      for (var validator in validators) {
        final validatorResult = validator.call(valueCandidate);
        if (validatorResult != null) {
          return validatorResult;
        }
      }
      return null;
    };
  }

  static FormFieldValidator<T> required<T>() {
    return FormBuilderValidators.required(errorText: 'Field tidak boleh kosong.');
  }

  static FormFieldValidator<String> phone({String? err}) {
    RegExp regex = RegExp(r'^8\d{8,13}$');
    return Validate.regex(regex: regex, err: err ?? 'Format nomor telepon masih salah.');
  }

  static FormFieldValidator<String> email({String? err}) {
    RegExp regex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return Validate.regex(regex: regex, err: err ?? 'Format email masih salah.');
  }

  static FormFieldValidator<String> password({String? err}) {
    RegExp regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');
    return Validate.regex(regex: regex, err: err ?? 'Format password masih salah.');
  }

  static FormFieldValidator<String> notEmpty({String? err}) {
    RegExp regex = RegExp(r'^\S+$');
    return Validate.regex(regex: regex, err: err ?? 'Field tidak boleh kosong.');
  }

  static FormFieldValidator<String> name({String? err}) {
    RegExp regex = RegExp(r"^[a-zA-Z]+(?: [a-zA-Z]+)*$");
    return Validate.regex(regex: regex, err: err ?? 'Format nama masih salah.');
  }

  static FormFieldValidator<String> confirmPassword(
      String Function() getPassword) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Field tidak boleh kosong.';
      }

      if (value != getPassword()) {
        return 'Password tidak sesuai.';
      }

      return null;
    };
  }

  static FormFieldValidator<String> newPassword() {
    return Validator.list([
      Validator.required(),
      FormBuilderValidators.minLength(8,
          errorText: 'Password minimal 8 karakter.'),
      Validate.regex(
          regex: RegExp(r'[A-Z]'), err: 'Password harus mengandung huruf besar.'),
      Validate.regex(
          regex: RegExp(r'[a-z]'), err: 'Password harus mengandung huruf kecil.'),
      Validate.regex(
          regex: RegExp(r'[0-9]'), err: 'Password harus mengandung angka.'),
    ]);
  }
}
