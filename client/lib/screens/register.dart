import 'package:flutter/material.dart';
import 'package:vecinapp/core/services/auth.service.dart';
import 'package:vecinapp/core/sizeConfig.dart';
import 'package:vecinapp/screens/user/lobby.dart';
import 'package:vecinapp/widgets/acceptAlert.dart';
import 'package:vecinapp/widgets/bottomTitle.dart';
import 'package:vecinapp/widgets/button.dart';
import 'package:vecinapp/widgets/homeImage.dart';
import 'package:vecinapp/widgets/inputPassword.dart';
import 'package:vecinapp/widgets/notificationAlert.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key, this.email}) : super(key: key);
  final String email;
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstPassGrabber = TextEditingController();
  final secondPassGrabber = TextEditingController();

  bool acceptTerms = false;
  bool focusFirstNode = false;

  LoginUser loginUser = LoginUser();

  Future<void> _showTermsDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AcceptAlert(
              title: 'Términos',
              body: 'Debe aceptar los términos',
              acceptPressed: () {
                this._changeTerms();
              }
          );
        }
    );
  }

  Future<void> _differentPassDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return NotificationAlert(
              title: 'Contraseñas',
              body: 'Las contraseñas deben coincidir'
          );
        }
    );
  }

  Future<void> _emptyPassDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AcceptAlert(
            title: 'Contraseñas',
            body: 'Debe escribir una contraseña',
            acceptPressed: () => this._requestFocus(),
          );
        }
    );
  }

  void _requestFocus() {
    setState(()
    {focusFirstNode = !focusFirstNode;}
    );
  }

  void _changeTerms() {
    setState(()
    {acceptTerms = !acceptTerms;}
    );
  }



  void _onPressed() {
    debugPrint(firstPassGrabber.text);
    debugPrint(secondPassGrabber.text);

    if (firstPassGrabber.text == '') {
      _emptyPassDialog();
      return;
    }

    if (firstPassGrabber.text != secondPassGrabber.text) {
      _differentPassDialog();
      return;
    }

    if (!acceptTerms) {
      _showTermsDialog();
      return;
    }
    var password = firstPassGrabber.text;

    _futureBuilder(password);

//    homeService.login(textGrabber.text)
//        .then((value) => debugPrint(value.email.toString()))
//        .catchError((onError) => debugPrint('ERROR'));
  }

  Future<void> _futureBuilder(password) async {
    debugPrint('TEST');
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return FutureBuilder(
              future: this.loginUser.register(widget.email, password),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [HomeImage(
                          photo: 'assets/images/logo.gif',
                          width: 150.0,
                          onTap: () {},
                        )]
                    );
                  case ConnectionState.done:
                    return SideBarLayout(snapshot.data.email);
                  default:
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [HomeImage(
                          photo: 'assets/images/logo.gif',
                          width: 150.0,
                          onTap: () {},
                        )]
                    );
                }
              }
          );
        }
    );

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
              child: Column(
                children: <Widget>[
                  InputPassword(
                      firstPassGrabber,
                      focusNode: focusFirstNode
                  ),
                  InputPassword(
                      secondPassGrabber
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Aceptar Terminos'),
                      Checkbox(
                        value: acceptTerms,
                        onChanged: (bool value) => this._changeTerms(),
                      ),],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 50.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: ButtonLogin(
                        onPressed: this._onPressed,
                      ),
                    ),
                  )
                ],
              )
          ),
            Align(
              alignment: Alignment.bottomLeft,
              child: BottomTitle('REGISTER'),
            )]
        )
    );

  }
}