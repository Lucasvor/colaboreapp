import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:date_format/date_format.dart';

class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static final RegExp _telRegExp = RegExp(
    r'^(\(\d{2}\)\s)(\d{4,5}\-\d{4})$',
  );

  static isValidDate(String strdate) {
    if (strdate.length == 10) {
      var sep = strdate.split("/");
      strdate = sep[2] + "-" + sep[1] + "-" + sep[0];
      try {
        DateTime date = DateTime.parse(strdate);
        if ((DateTime.now().difference(date).inDays / 365).floor() >= 18)
          return true;
        else
          return false;
      } catch (e) {
        return false;
      }
    } else
      return false;
  }

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidCpf(String cpf) {
    return CPFValidator.isValid(cpf);
  }

  static isValidCnpj(String cnpj) {
    return CNPJValidator.isValid(cnpj);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static isValidTelefone(String telefone) {
    return _telRegExp.hasMatch(telefone);
  }
}
