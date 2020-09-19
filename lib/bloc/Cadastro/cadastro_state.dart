part of 'cadastro_bloc.dart';

class CadastroState {
  final bool isCpfValid;
  final bool isSenhaValid;
  final bool isSubmitting;
  final bool isTelValid;
  final bool isDataNascimentoValid;
  final bool isEmailValid;
  final bool isSenhaPage;
  final bool isSucess;
  final bool isFailure;
  final String message;

  CadastroState({
    this.message,
    this.isCpfValid,
    this.isSenhaValid,
    this.isSubmitting,
    this.isSenhaPage,
    this.isSucess,
    this.isFailure,
    this.isTelValid,
    this.isDataNascimentoValid,
    this.isEmailValid,
  });
  bool get isFormValid => isCpfValid && isSenhaValid;

  factory CadastroState.initial() {
    return CadastroState(
        isCpfValid: true,
        isSenhaValid: true,
        isDataNascimentoValid: true,
        isEmailValid: true,
        isSenhaPage: false,
        isTelValid: true,
        isSubmitting: false,
        isSucess: false,
        isFailure: false);
  }

  factory CadastroState.loading() {
    return CadastroState(
        isCpfValid: true,
        isSenhaValid: true,
        isDataNascimentoValid: true,
        isEmailValid: true,
        isSenhaPage: false,
        isTelValid: true,
        isSubmitting: true,
        isSucess: false,
        isFailure: false);
  }

  factory CadastroState.failure({String message}) {
    return CadastroState(
        message: message,
        isCpfValid: true,
        isSenhaValid: true,
        isDataNascimentoValid: true,
        isEmailValid: true,
        isTelValid: true,
        isSenhaPage: false,
        isSubmitting: false,
        isSucess: false,
        isFailure: true);
  }
  factory CadastroState.sucess() {
    return CadastroState(
        isCpfValid: true,
        isSenhaValid: true,
        isDataNascimentoValid: true,
        isEmailValid: true,
        isTelValid: true,
        isSenhaPage: true,
        isSubmitting: false,
        isSucess: true,
        isFailure: false);
  }

  CadastroState update(
      {bool isCpfValid,
      bool isSenhaValid,
      bool isConfirmaSenhaValid,
      bool isDataNascimentoValid,
      bool isSenhaPage,
      bool isEmailValid,
      bool isTelValid}) {
    return copyWith(
        isCpfValid: isCpfValid,
        isSenhaValid: isSenhaValid,
        isDataNascimentoValid: isDataNascimentoValid,
        isEmailValid: isEmailValid,
        isTelValid: isTelValid,
        isSenhaPage: isSenhaPage,
        isSubmitting: false,
        isSucess: false,
        isFailure: false);
  }

  CadastroState copyWith({
    bool isCpfValid,
    bool isSenhaValid,
    bool isSubmitting,
    bool isDataNascimentoValid,
    bool isEmailValid,
    bool isTelValid,
    bool isSenhaPage,
    bool isSucess,
    bool isFailure,
  }) {
    return CadastroState(
        isCpfValid: isCpfValid ?? this.isCpfValid,
        isSenhaValid: isSenhaValid ?? this.isSenhaValid,
        isDataNascimentoValid:
            isDataNascimentoValid ?? this.isDataNascimentoValid,
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isTelValid: isTelValid ?? this.isTelValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSenhaPage: isSenhaPage ?? this.isSenhaPage,
        isSucess: isSucess ?? this.isSucess,
        isFailure: isFailure ?? this.isFailure);
  }
}
