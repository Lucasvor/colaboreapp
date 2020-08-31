import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:colaboreapp/utils/validators.dart';
import 'package:equatable/equatable.dart';

part 'cadastro_event.dart';
part 'cadastro_state.dart';

class CadastroBloc extends Bloc<CadastroEvent, CadastroState> {
  final UserRepository userRepository;
  CadastroBloc(this.userRepository) : super(CadastroState.initial());

  @override
  Stream<CadastroState> mapEventToState(
    CadastroEvent event,
  ) async* {
    if (event is CadastroCpfChanged) {
      yield* _mapCadastroCpfChangeToState(event.cpf);
    } else if (event is CadastroSenhaChanged) {
      yield* _mapCadastroSenhaChangeToState(event.senha);
    } else if (event is CadastroSubmitted) {
      yield* _mapCadastroSubmittedToState(
          nome: event.nome, senha: event.senha, cpf: event.cpf);
    }
  }

  Stream<CadastroState> _mapCadastroCpfChangeToState(String cpf) async* {
    yield state.update(isCpfValid: Validators.isValidCpf(cpf));
  }

  Stream<CadastroState> _mapCadastroSenhaChangeToState(String senha) async* {
    yield state.update(isSenhaValid: Validators.isValidPassword(senha));
  }

  Stream<CadastroState> _mapCadastroSubmittedToState(
      {String nome, String cpf, String senha}) async* {
    yield CadastroState.loading();

    try {
      var user = await userRepository.createUser(
          cpf.replaceAll(".", "").replaceAll("-", ""), senha, nome);

      yield CadastroState.sucess();
    } on Exception catch (e) {
      print(e.toString());
      yield CadastroState.failure(
          message: e.toString().replaceAll('Exception', ''));
    }
  }
}
