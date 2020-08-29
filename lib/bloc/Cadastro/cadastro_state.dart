part of 'cadastro_bloc.dart';

abstract class CadastroState extends Equatable {
  const CadastroState();

  @override
  List<Object> get props => [];
}

class CadastroInitial extends CadastroState {}

class CadastroLoadingState extends CadastroState {}

class CadastroSuccessfulState extends CadastroState {
  final FirebaseUser user;

  CadastroSuccessfulState(this.user);
}

class CadastroFailure extends CadastroState {
  final String message;

  CadastroFailure(this.message);
}
