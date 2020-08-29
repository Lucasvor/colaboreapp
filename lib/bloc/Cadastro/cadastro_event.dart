part of 'cadastro_bloc.dart';

abstract class CadastroEvent extends Equatable {
  const CadastroEvent();

  @override
  List<Object> get props => [];
}

class CadastrarPressedEvent extends CadastroEvent {
  final String cpf;
  final String senha;

  CadastrarPressedEvent({@required this.cpf, @required this.senha});
}
