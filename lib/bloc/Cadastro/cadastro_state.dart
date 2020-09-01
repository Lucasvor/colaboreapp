part of 'cadastro_bloc.dart';

class CadastroState {
  final bool isCpfValid;
  final bool isSenhaValid;
  final bool isSubmitting;
  final bool isSucess;
  final bool isFailure;
  final String message;
  bool isConfirmaSenhaValid;

  CadastroState(
      {this.message,
      this.isCpfValid,
      this.isSenhaValid,
      this.isConfirmaSenhaValid,
      this.isSubmitting,
      this.isSucess,
      this.isFailure});

  bool get isFormValid => isCpfValid && isSenhaValid;

  factory CadastroState.initial() {
    return CadastroState(
        isCpfValid: true,
        isSenhaValid: true,
        isSubmitting: false,
        isSucess: false,
        isFailure: false);
  }

  factory CadastroState.loading() {
    return CadastroState(
        isCpfValid: true,
        isSenhaValid: true,
        isSubmitting: true,
        isSucess: false,
        isFailure: false);
  }

  factory CadastroState.failure({String message}) {
    return CadastroState(
        message: message,
        isCpfValid: true,
        isSenhaValid: true,
        isSubmitting: false,
        isSucess: false,
        isFailure: true);
  }
  factory CadastroState.sucess() {
    return CadastroState(
        isCpfValid: true,
        isSenhaValid: true,
        isSubmitting: false,
        isSucess: true,
        isFailure: false);
  }

  CadastroState update({
    bool isCpfValid,
    bool isSenhaValid,
  }) {
    return copyWith(
        isCpfValid: isCpfValid,
        isSenhaValid: isSenhaValid,
        isSubmitting: false,
        isSucess: false,
        isFailure: false);
  }

  CadastroState copyWith({
    bool isCpfValid,
    bool isSenhaValid,
    bool isSubmitting,
    bool isSucess,
    bool isFailure,
  }) {
    return CadastroState(
        isCpfValid: isCpfValid ?? this.isCpfValid,
        isSenhaValid: isSenhaValid ?? this.isSenhaValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSucess: isSucess ?? this.isSucess,
        isFailure: isFailure ?? this.isFailure);
  }
}
