import 'package:flutter/material.dart';
import 'package:vecinapp/core/services/auth.service.dart';
import 'package:vecinapp/core/sizeConfig.dart';
import 'package:vecinapp/widgets/acceptAlert.dart';
import 'package:vecinapp/widgets/bottomTitle.dart';
import 'package:vecinapp/widgets/button.dart';
import 'package:vecinapp/widgets/homeImage.dart';
import 'package:vecinapp/widgets/inputEmail.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  final textGrabber = TextEditingController();
  HomeService homeService = HomeService();
  @override

  Future<void> _emptyEmailDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AcceptAlert(
            title: 'Usuario',
            body: 'Debe introducir un usuario',
            acceptPressed: () {},
          );
        }
    );
  }


  void dispose() {
    // Clean up the controller when the widget is disposed.
    textGrabber.dispose();
    super.dispose();
  }
  void _onPressed() {
    debugPrint(textGrabber.text);
    var email = textGrabber.text;
    if (email == '') {
      _emptyEmailDialog();
      return;
    }
    Navigator.pushNamed(
        context,
        '/userLogin',
        arguments: {"email": email});
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Color(0xff87a4d3), Colors.white70]),
              ),
              padding: const EdgeInsets.only(top: 40.0),
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  HomeImage(
                    photo: 'assets/images/250Logo.png',
                    width: 150.0,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  InputEmail(
                    controller: textGrabber
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: ButtonLogin(
                        onPressed: this._onPressed,
                      ),
                    ),
                  ),
                ],
              )
          ),
            Align(
              alignment: Alignment.bottomLeft,
              child: BottomTitle('LOGIN'),
            )
          ]
        )
    );
  }
}
