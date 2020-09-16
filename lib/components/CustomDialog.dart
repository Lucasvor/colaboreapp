import 'package:colaboreapp/Screens/Cadastro/cadastro.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final UserRepository userRepository;

  const CustomDialog(
      {Key key,
      this.title,
      this.description,
      this.buttonText,
      this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 16,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 16.0),
              Text(
                'Olá,\n Escolha como sera cadastrado.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: size.height * 0.15,
                    margin: EdgeInsets.all(15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return Cadastro(
                                  userRepository: userRepository,
                                  selecionaCadastro: true,
                                );
                              },
                            ),
                          );
                        },
                        color: kPrimaryColorGreen,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/images/donor-card.svg",
                              height: size.height * 0.09,
                            ),
                            Text(
                              'Doador',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.15,
                    margin: EdgeInsets.all(15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return Cadastro(
                                  userRepository: userRepository,
                                  selecionaCadastro: false,
                                );
                              },
                            ),
                          );
                        },
                        color: kPrimaryColorGreen,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/images/insurance.svg",
                              height: size.height * 0.09,
                            ),
                            Text(
                              'ONG',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                  },
                  child: Text('Voltar'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
