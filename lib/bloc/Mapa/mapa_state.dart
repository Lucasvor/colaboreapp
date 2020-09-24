part of 'mapa_bloc.dart';

abstract class MapaState extends Equatable {
  const MapaState();

  @override
  List<Object> get props => [];
}

class MapaInitial extends MapaState {}

class MapaSucess extends MapaState {}

class MapaPegandoPosicaoState extends MapaState {}

class MapaPegaPosicaoState extends MapaState {
  final LocationData locationData;

  MapaPegaPosicaoState(this.locationData);
  @override
  List<Object> get props => [locationData];
}

class MapaError extends MapaState {
  final String message;

  MapaError(this.message);

  @override
  List<Object> get props => [message];
}
