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
  final bool isSenhaValid;
  final bool isSubmitting;
  final bool isSucess;
  final bool isFailure;
  final String message;

  LoginState(
      {this.message,
      this.isCpfValid,
      this.isSenhaValid,
      this.isSubmitting,
      this.isSucess,
      this.isFailure});

  bool get isFormValid => isCpfValid && isSenhaValid;

  factory LoginState.initial() {
    return LoginState(
        isCpfValid: true,
        isSenhaValid: true,
        isSubmitting: false,
        isSucess: false,
        isFailure: false);
  }

  factory LoginState.loading() {
    return LoginState(
        isCpfValid: true,
        isSenhaValid: true,
        isSubmitting: true,
        isSucess: false,
        isFailure: false);
  }

  factory LoginState.failure({String message}) {
    return LoginState(
        message: message,
        isCpfValid: true,
        isSenhaValid: true,
        isSubmitting: false,
        isSucess: false,
        isFailure: true);
  }
  factory LoginState.sucess() {
    return LoginState(
        isCpfValid: true,
        isSenhaValid: true,
        isSubmitting: false,
        isSucess: true,
        isFailure: false);
  }

  LoginState update({
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

  LoginState copyWith({
    bool isCpfValid,
    bool isSenhaValid,
    bool isSubmitting,
    bool isSucess,
    bool isFailure,
  }) {
    return LoginState(
        isCpfValid: isCpfValid ?? this.isCpfValid,
        isSenhaValid: isSenhaValid ?? this.isSenhaValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSucess: isSucess ?? this.isSucess,
        isFailure: isFailure ?? this.isFailure);
  }
}
