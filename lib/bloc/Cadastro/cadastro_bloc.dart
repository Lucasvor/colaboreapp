import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:colaboreapp/Model/usuario.dart';
import 'package:colaboreapp/repositories/FirestoreUserRepository.dart';
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
    } else if (event is CadastroTelChanged) {
      yield* _mapCadastroTelChangeToState(event.telefone);
    } else if (event is CadastroEmailChanged) {
      yield* _mapCadastroEmailChangeToState(event.email);
    } else if (event is CadastroDateChanged) {
      yield* _mapCadastroDateChangeToState(event.date);
    } else if (event is CadastroSubmitted) {
      yield* _mapCadastroSubmittedToState(
        nome: event.nome,
        senha: event.senha,
        cpf: event.cpf,
        date: event.dataNascimento,
        email: event.email,
        tel: event.telefone,
      );
    }
  }

  Stream<CadastroState> _mapCadastroEmailChangeToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<CadastroState> _mapCadastroDateChangeToState(String date) async* {
    yield state.update(isDataNascimentoValid: Validators.isValidDate(date));
  }

  Stream<CadastroState> _mapCadastroTelChangeToState(String telefone) async* {
    yield state.update(isTelValid: Validators.isValidTelefone(telefone));
  }

  Stream<CadastroState> _mapCadastroCpfChangeToState(String cpf) async* {
    yield state.update(isCpfValid: Validators.isValidCpf(cpf));
  }

  Stream<CadastroState> _mapCadastroSenhaChangeToState(String senha) async* {
    yield state.update(isSenhaValid: Validators.isValidPassword(senha));
  }

  Stream<CadastroState> _mapCadastroSubmittedToState(
      {String nome,
      String cpf,
      String senha,
      String date,
      String tel,
      String email}) async* {
    yield CadastroState.loading();

    try {
      cpf = cpf.replaceAll(".", "").replaceAll("-", "");
      await userRepository.createUser(cpf, senha, nome);
      var firestore = FirestoreUserRepository();

      var sep = date.split("/");
      date = sep[2] + "-" + sep[1] + "-" + sep[0];

      await firestore.addNewUsuario(
        Usuario(
          senha: senha,
          cpf: cpf,
          nome: nome,
          dataNascimento: DateTime.parse(date),
          telefone: tel,
          email: email,
          face: "face0",
        ),
      );
      yield CadastroState.sucess();
    } on Exception catch (e) {
      print(e.toString());
      yield CadastroState.failure(
          message: e.toString().replaceAll('Exception', ''));
    }
  }
}
