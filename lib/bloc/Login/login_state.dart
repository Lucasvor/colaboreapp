part of 'login_bloc.dart';

// abstract class LoginState extends Equatable {
//   const LoginState();

//   @override
//   List<Object> get props => [];
// }

// class LoginInitial extends LoginState {}

// class LoginLoadingState extends LoginState {}

// class LoginSucessState extends LoginState {
//   final User user;

//   LoginSucessState(this.user);
// }

// class LoginFailureState extends LoginState {
//   final String message;

//   LoginFailureState(this.message);
// }

class LoginState {
  final bool isCpfValid;
  final bool isCnpjValid;
  final bool isSenhaValid;
  final bool isSubmitting;
  final bool isSucessDoador;
  final bool isSucessOng;
  final bool isFailure;
  final String message;

  LoginState(
      {this.message,
      this.isCpfValid,
      this.isCnpjValid,
      this.isSenhaValid,
      this.isSubmitting,
      this.isSucessDoador,
      this.isSucessOng,
      this.isFailure});

  bool get isFormValid => isCpfValid && isSenhaValid;

  factory LoginState.initial() {
    return LoginState(
        isCpfValid: true,
        isCnpjValid: true,
        isSenhaValid: true,
        isSubmitting: false,
        isSucessOng: false,
        isSucessDoador: false,
        isFailure: false);
  }

  factory LoginState.loading() {
    return LoginState(
        isCpfValid: true,
        isCnpjValid: true,
        isSenhaValid: true,
        isSubmitting: true,
        isSucessDoador: false,
        isSucessOng: false,
        isFailure: false);
  }

  factory LoginState.failure({String message}) {
    return LoginState(
        message: message,
        isCpfValid: true,
        isCnpjValid: true,
        isSenhaValid: true,
        isSubmitting: false,
        isSucessDoador: false,
        isFailure: true);
  }
  factory LoginState.sucessDoador() {
    return LoginState(
        isCpfValid: true,
        isCnpjValid: true,
        isSenhaValid: true,
        isSubmitting: false,
        isSucessDoador: true,
        isSucessOng: false,
        isFailure: false);
  }
  factory LoginState.sucessOng() {
    return LoginState(
        isCpfValid: true,
        isCnpjValid: true,
        isSenhaValid: true,
        isSubmitting: false,
        isSucessDoador: false,
        isSucessOng: true,
        isFailure: false);
  }

  LoginState update({
    bool isCpfValid,
    bool isSenhaValid,
    bool isCnpjValid,
  }) {
    return copyWith(
        isCpfValid: isCpfValid,
        isSenhaValid: isSenhaValid,
        isCnpjValid: isCnpjValid,
        isSubmitting: false,
        isSucessDoador: false,
        isSucessOng: false,
        isFailure: false);
  }

  LoginState copyWith({
    bool isCpfValid,
    bool isCnpjValid,
    bool isSenhaValid,
    bool isSubmitting,
    bool isSucessDoador,
    bool isSucessOng,
    bool isFailure,
  }) {
    return LoginState(
        isCpfValid: isCpfValid ?? this.isCpfValid,
        isCnpjValid: isCnpjValid ?? this.isCnpjValid,
        isSenhaValid: isSenhaValid ?? this.isSenhaValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSucessDoador: isSucessDoador ?? this.isSucessDoador,
        isSucessOng: isSucessOng ?? this.isSucessOng,
        isFailure: isFailure ?? this.isFailure);
  }
}
