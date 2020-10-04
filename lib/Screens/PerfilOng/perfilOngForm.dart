import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:colaboreapp/Model/ong.dart';
import 'package:colaboreapp/Screens/ValorDoacao/valorDoacao.dart';
import 'package:colaboreapp/bloc/Home/home_bloc.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:colaboreapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PerfilOngForm extends StatefulWidget {
  final Ong ong;
  final String ongNome;
  final HomeBloc homeBloc;
  PerfilOngForm({Key key, this.ong, this.ongNome, this.homeBloc})
      : super(key: key);

  @override
  _PerfilOngFormState createState() => _PerfilOngFormState();
}

class _PerfilOngFormState extends State<PerfilOngForm> {
  GoogleMapController mapController;
  Set<Marker> _markers = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.add(
      Marker(
          markerId: MarkerId(widget.ong.nome),
          position: LatLng(
            widget.ong.latitude,
            widget.ong.longitude,
          ),
          infoWindow: InfoWindow(title: "${widget.ong.nome}"),
          icon: BitmapDescriptor.defaultMarker),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                  Hero(
                    tag: '${widget.ong.nome}',
                    child: CachedNetworkImage(
                      height: size.height * 0.3,
                      width: size.width,
                      imageUrl: widget.ong.imageUrl,
                      placeholder: (context, url) =>
                          new CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 36,
                      color: kPrimaryColorGreen,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
              Container(
                width: size.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        widget.ong.nome,
                        style: TextStyle(
                          fontSize: 26,
                          color: kPrimaryColorGreen,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.assistant_photo,
                            color: kPrimaryColorGreen,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              widget.ong.endereco,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.call,
                            color: kPrimaryColorGreen,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              widget.ong.telefone,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text("Mais Detalhes"),
                        children: <Widget>[
                          SingleChildScrollView(
                            child: AutoSizeText(
                              widget.ong.info,
                              minFontSize: 14,
                              maxFontSize: 19,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black38,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: size.width,
                height: size.height * 0.3,
                child: GoogleMap(
                  markers: _markers,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: false,
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      widget.ong.latitude,
                      widget.ong.longitude,
                    ),
                    zoom: 15,
                  ),
                ),
              ),
              // Container(
              //   height: size.height * 0.3,
              //   margin: EdgeInsets.all(3),
              //   padding: EdgeInsets.all(3),
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       color: Colors.green[200],
              //     ),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: SingleChildScrollView(
              //     child: Text(
              //       widget.ong.info ?? "",
              //       style: TextStyle(
              //         fontSize: 19,
              //         color: Colors.black38,
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundedButton(
                  color: kPrimaryColorGreen,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ValorDoacaoForm(
                          homeBloc: widget.homeBloc,
                          ong: widget.ong,
                        ),
                      ),
                    );
                  },
                  text: 'Doar',
                  textColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
