import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:colaboreapp/Model/ong.dart';
import 'package:colaboreapp/Screens/PerfilOng/perfilOng.dart';
import 'package:colaboreapp/Screens/PerfilOng/perfilOngForm.dart';
import 'package:colaboreapp/bloc/Home/home_bloc.dart';
import 'package:colaboreapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ListOngs extends StatefulWidget {
  final List<Ong> ongs;
  final HomeBloc homeBloc;

  const ListOngs({Key key, this.ongs, this.homeBloc}) : super(key: key);

  @override
  _ListOngsState createState() => _ListOngsState();
}

class _ListOngsState extends State<ListOngs> {
  TextEditingController searchController = new TextEditingController();
  String filter;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: kPrimaryColorGreen,
                  ),
                ),
              ],
            ),
            // Padding(
            //   padding: EdgeInsets.all(10),
            //   child: TextField(
            //     controller: searchController,
            //     decoration: InputDecoration(
            //       hintText: 'Busque a Ong',
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //     ),
            //   ),
            // ),
            FittedBox(
              fit: BoxFit.cover,
              child: AutoSizeText(
                'Selecionar Ong',
                textAlign: TextAlign.center,
                minFontSize: 25,
                maxFontSize: 30,
                style: TextStyle(
                    color: kPrimaryColorGreen, fontWeight: FontWeight.bold),
              ),
            ),
            SvgPicture.asset(
              "assets/images/Search-rafiki.svg",
              height: 100,
              width: 100,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.ongs.length,
                itemBuilder: (context, index) {
                  return filter == null || filter == ""
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: ListTile(
                            title: Text('${widget.ongs[index].nome}'),
                            leading: _buildCircleAvatar(
                                widget.ongs[index].imageUrl,
                                widget.ongs[index].nome),
                            trailing: Wrap(
                              children: <Widget>[
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: kPrimaryColorGreen,
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PerfilOng(
                                    homeBloc: widget.homeBloc,
                                    ong: widget.ongs[index],
                                    ongNome: widget.ongs[index].nome,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : '${widget.ongs[index].nome}'.contains(filter)
                          ? ListTile(
                              title: Text('${widget.ongs[index].nome}'),
                              leading: _buildCircleAvatar(
                                  widget.ongs[index].imageUrl,
                                  widget.ongs[index].nome),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PerfilOng(
                                      homeBloc: widget.homeBloc,
                                      ong: widget.ongs[index],
                                      ongNome: widget.ongs[index].nome,
                                    ),
                                  ),
                                );
                              },
                            )
                          : new Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleAvatar(String url, String nome) {
    return Hero(
      tag: nome,
      child: ClipOval(
        child: AspectRatio(
          aspectRatio: 1,
          child: CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
