import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;
  LoginBloc(this.userRepository) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressedEvent) {
      try {
        yield LoginLoadingState();
        var user = await userRepository.singInUser(event.cpf, event.senha);
        yield LoginSucessState(user);
      } on PlatformException catch (e) {
        yield LoginFailureState(e.message);
      }
    }
  }
}
