import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Mapa extends StatefulWidget {
  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  GoogleMapController mapController;
  Location location;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  bool showButton = true;

  static const LatLng center = const LatLng(45.521563, -122.677433);
  LatLng _lastMapPosition = center;
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    location = new Location();
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
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
        showButton = false;
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
        showButton = true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
        backgroundColor: Colors.green[700],
      ),
      body: Stack(
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
                  Visibility(
                    child: FloatingActionButton(
                      onPressed: _getCurrentPositionButtonPressed,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.location_searching, size: 36.0),
                    ),
                    visible: showButton,
                  ),
                  // SizedBox(height: 16.0),
                  // FloatingActionButton(
                  //   onPressed: _onAddMarkerButtonPressed,
                  //   backgroundColor: Colors.green,
                  //   child: const Icon(Icons.add_location, size: 36.0),
                  // )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
