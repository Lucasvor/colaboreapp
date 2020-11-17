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
      if (event is LoginDocumentChange) {
        yield* _mapLoginDocumentChangeToState(event.documento);
      } else if (event is LoginSenhaChange) {
        yield* _mapLoginSenhaChangeToState(event.senha);
      } else if (event is LoginWithCredentialsPressed) {
        yield* _mapLoginWithCredentialsToState(event.documento, event.senha);
      }
    } on PlatformException catch (e) {
      yield LoginState.failure(message: e.message);
    }
  }

  Stream<LoginState> _mapLoginDocumentChangeToState(String document) async* {
    if (document.length <= 14)
      yield state.update(isCpfValid: Validators.isValidCpf(document));
    else if (document.length > 14)
      yield state.update(isCnpjValid: Validators.isValidCnpj(document));
  }

  Stream<LoginState> _mapLoginSenhaChangeToState(String senha) async* {
    yield state.update(isSenhaValid: Validators.isValidPassword(senha));
  }

  Stream<LoginState> _mapLoginWithCredentialsToState(
      String documento, senha) async* {
    yield LoginState.loading();
    try {
      documento =
          documento.replaceAll(".", "").replaceAll("-", "").replaceAll("/", "");
      await userRepository.singInUser(documento, senha);
      if (documento.length == 11) {
        yield LoginState.sucessDoador();
      } else {
        yield LoginState.sucessOng();
      }
    } on Exception catch (e) {
      yield LoginState.failure(
          message: e.toString().replaceAll('Exception', ''));
    }
  }
}
