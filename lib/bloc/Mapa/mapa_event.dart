part of 'mapa_bloc.dart';

abstract class MapaEvent extends Equatable {
  const MapaEvent();

  @override
  List<Object> get props => [];
}

class MapaInicial extends MapaEvent {
  @override
  List<Object> get props => [];
}

class MapaCarregaOngs extends MapaEvent {
  final Set<Marker> markers;
  final List<Ong> ongs;

  MapaCarregaOngs(this.markers, this.ongs);

  @override
  List<Object> get props => [];
}

class MapaPegaPosicao extends MapaEvent {
  @override
  List<Object> get props => [];
}
