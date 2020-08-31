import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:colaboreapp/utils/validators.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  LoginBloc(this.userRepository) : super(LoginState.initial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    try {
      if (event is LoginCpfChange) {
        yield* _mapLoginCpfChangeToState(event.cpf);
      } else if (event is LoginSenhaChange) {
        yield* _mapLoginSenhaChangeToState(event.senha);
      } else if (event is LoginWithCredentialsPressed) {
        yield* _mapLoginWithCredentialsToState(event.cpf, event.senha);
      }
    } on PlatformException catch (e) {
      yield LoginState.failure(message: e.message);
    }
  }

  Stream<LoginState> _mapLoginCpfChangeToState(String cpf) async* {
    yield state.update(isCpfValid: Validators.isValidCpf(cpf));
  }

  Stream<LoginState> _mapLoginSenhaChangeToState(String senha) async* {
    yield state.update(isSenhaValid: Validators.isValidPassword(senha));
  }

  Stream<LoginState> _mapLoginWithCredentialsToState(String cpf, senha) async* {
    yield LoginState.loading();
    try {
      await userRepository.singInUser(
          cpf.replaceAll(".", "").replaceAll("-", ""), senha);
      yield LoginState.sucess();
    } on Exception catch (e) {
      yield LoginState.failure(
          message: e.toString().replaceAll('Exception', ''));
    }
  }
}
