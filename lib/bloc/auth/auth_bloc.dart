import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  AuthBloc(this.userRepository) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    try {
      if (event is AuthSplash) {
        yield* _mapAuthSplashToState();
      } else if (event is AuthStarted) {
        yield* _mapAuthStartedToState();
      } else if (event is AuthLoggedIn) {
        yield* _mapAuthLoggedInToState();
      } else if (event is AuthLoggedOut) {
        yield* _mapAuthLoggedOutToState();
      }
    } on PlatformException catch (e) {
      yield AuthErrorState(e.message);
    }
  }

// ! Splash Auth
  Stream<AuthState> _mapAuthSplashToState() async* {
    yield AuthSplashState();
    await Future.delayed(Duration(seconds: 6));
    yield* _mapAuthStartedToState();
  }

// ! Saida Auth

  Stream<AuthState> _mapAuthLoggedOutToState() async* {
    yield UnAuthState();
    userRepository.singOut();
  }

// ! Login Auth
  Stream<AuthState> _mapAuthLoggedInToState() async* {
    yield AuthSucessState(user: await userRepository.getCurrentUser());
  }

// ! Autenticação
  Stream<AuthState> _mapAuthStartedToState() async* {
    final isSignedIn = await userRepository.isSignedIn();
    if (isSignedIn) {
      final user = await userRepository.getCurrentUser();
      yield AuthSucessState(user: user);
    } else {
      yield UnAuthState();
    }
  }
}
