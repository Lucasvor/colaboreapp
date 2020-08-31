import 'package:cpf_cnpj_validator/cpf_validator.dart';

class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidCpf(String cpf) {
    return CPFValidator.isValid(cpf);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
