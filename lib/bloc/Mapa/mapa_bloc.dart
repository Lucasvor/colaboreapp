import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaInitial());

  bool _serviceEnabled;
  Location location = new Location();
  PermissionStatus _permissionGranted;

  @override
  Stream<MapaState> mapEventToState(
    MapaEvent event,
  ) async* {
    // TODO: implement mapEventToState
    try {
      if (event is MapaInicial) {
      } else if (event is MapaPegaPosicao) {
        yield* mapPegaPosicao();
      }
    } catch (e) {
      yield MapaError(e.toString());
    }
  }

  Stream<MapaState> mapPegaPosicao() async* {
    yield MapaPegandoPosicaoState();
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    yield MapaPegaPosicaoState(await location.getLocation());
  }
}
