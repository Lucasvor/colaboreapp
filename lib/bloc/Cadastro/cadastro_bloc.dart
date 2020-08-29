import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

part 'cadastro_event.dart';
part 'cadastro_state.dart';

class CadastroBloc extends Bloc<CadastroEvent, CadastroState> {
  final UserRepository userRepository;
  CadastroBloc(this.userRepository) : super(CadastroInitial());

  CadastroState get initialState => CadastroInitial();

  @override
  Stream<CadastroState> mapEventToState(
    CadastroEvent event,
  ) async* {
    try {
      if (event is CadastrarPressedEvent) {
        yield CadastroLoadingState();
        var user = await userRepository.createUser(event.cpf, event.senha);
        yield CadastroSuccessfulState(user);
      }
    } on PlatformException catch (e) {
      yield CadastroFailure(e.message);
    }
  }
}
