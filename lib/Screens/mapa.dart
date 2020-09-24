import 'package:colaboreapp/Model/ong.dart';
import 'package:colaboreapp/bloc/Home/home_bloc.dart';
import 'package:colaboreapp/bloc/Mapa/mapa_bloc.dart';
import 'package:colaboreapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../main.dart';

class Mapa extends StatefulWidget {
  final List<Ong> ongs;

  const Mapa({Key key, this.ongs}) : super(key: key);
  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  GoogleMapController mapController;
  Location location;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  MapaBloc _mapaBloc;
  FloatingActionButton floatingActionButton;

  static const LatLng center = const LatLng(-23.564457, -46.6527861);
  LatLng _lastMapPosition = center;
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    location = new Location();
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    floatingActionButton = FloatingActionButton(
      onPressed: () {
        _mapaBloc.add(MapaPegaPosicao());
      }, //_getCurrentPositionButtonPressed,
      backgroundColor: Colors.green,
      child: const Icon(Icons.location_searching, size: 36.0),
    );
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title:
              'Minha Posição: LAT: ${_lastMapPosition.latitude} e LONG: ${_lastMapPosition.longitude}',
          snippet: 'Bla Bla Bla',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _getCurrentPositionButtonPressed() async {
    //Verifica se o serviço de localização está habilitado se não solicita ao usuário
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
    _locationData = await location.getLocation();
    print(_locationData);
    var latlng = LatLng(_locationData.latitude, _locationData.longitude);
    setState(
      () {
        mapController.moveCamera(CameraUpdate.newLatLngZoom(
            LatLng(_locationData.latitude, _locationData.longitude), 16));

        _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(latlng.toString()),
          position: latlng,
          infoWindow: InfoWindow(
            title: 'Minha Posição',
            snippet: 'LAT: ${latlng.latitude} e LONG: ${latlng.longitude}',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.cover,
          child: Text('Localize as ONGs proximas a você'),
        ),
        backgroundColor: kPrimaryColorGreen,
      ),
      body: BlocProvider(
        create: (context) => MapaBloc(),
        child: BlocListener<MapaBloc, MapaState>(
          listener: (context, state) {
            if (state is MapaInitial) {
              _mapaBloc = BlocProvider.of<MapaBloc>(context);
            }
            if (state is MapaError) {
              Scaffold.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Erro: ${state.message}'),
                        Icon(Icons.error),
                      ],
                    ),
                    backgroundColor: HexColor("91C7A6"),
                  ),
                );
            }
            if (state is MapaPegandoPosicaoState) {
              floatingActionButton = FloatingActionButton(
                onPressed: null, //_getCurrentPositionButtonPressed,
                backgroundColor: Colors.green,
                child: const Icon(Icons.location_searching, size: 36.0),
              );
            }
            if (state is MapaPegaPosicaoState) {
              var latlng = LatLng(
                  state.locationData.latitude, state.locationData.longitude);
              setState(() {
                mapController
                    .moveCamera(CameraUpdate.newLatLngZoom(latlng, 16));

                _markers.add(Marker(
                  // This marker id can be anything that uniquely identifies each marker.
                  markerId: MarkerId(latlng.toString()),
                  position: latlng,
                  infoWindow: InfoWindow(
                    title: 'Minha Posição',
                    snippet:
                        'LAT: ${latlng.latitude} e LONG: ${latlng.longitude}',
                  ),
                  icon: BitmapDescriptor.defaultMarker,
                ));
              });
              floatingActionButton = FloatingActionButton(
                onPressed: () {
                  _mapaBloc.add(MapaPegaPosicao());
                }, //_getCurrentPositionButtonPressed,
                backgroundColor: Colors.green,
                child: const Icon(Icons.location_searching, size: 36.0),
              );
              //Desabilita o botão de pegar a posição.
            }
          },
          child: BlocBuilder<MapaBloc, MapaState>(
            builder: (context, state) {
              _mapaBloc = BlocProvider.of<MapaBloc>(context);
              return Stack(
                children: <Widget>[
                  GoogleMap(
                    onMapCreated: _onMapCreated,
                    onCameraMove: _onCameraMove,
                    markers: _markers,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: false,
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: center,
                      zoom: 11.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          floatingActionButton,
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
