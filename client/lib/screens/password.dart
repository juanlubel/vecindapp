import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:vecinapp/core/services/auth.service.dart';
import 'package:vecinapp/core/sizeConfig.dart';
import 'package:vecinapp/screens/user/lobby.dart';
import 'package:vecinapp/widgets/acceptAlert.dart';
import 'package:vecinapp/widgets/bottomTitle.dart';
import 'package:vecinapp/widgets/button.dart';
import 'package:vecinapp/widgets/homeImage.dart';
import 'package:vecinapp/widgets/inputPassword.dart';
import 'package:vecinapp/widgets/notificationAlert.dart';



class PasswordScreen extends StatefulWidget {
  PasswordScreen({Key key, this.email}) : super(key: key);
  final String email;

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final textGrabber = TextEditingController();
  bool focusFirstNode = false;
  bool wrongPass = false;
  LoginUser loginUser = LoginUser();
  
  Future<void> _emptyPassDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AcceptAlert(
            title: 'Contraseña',
            body: 'Debe escribir una contraseña',
            acceptPressed: () => this._requestFocus(),
          );
        }
    );
  }

  Future<void> _errorPassword() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return NotificationAlert(
            title: 'Contraseña',
            body: 'Contraseña Incorrecta'
          );
        }
    );
  }

  Future<void> _futureBuilder(password) async {
    debugPrint('TEST');
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xff87a4d3), Colors.white70]),
            ),
            child: FutureBuilder(
                future: this.loginUser.login(widget.email, password),
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
            ),
          );
        }
    );

  }

  void _requestFocus() {
    setState(()
    {focusFirstNode = !focusFirstNode;}
    );
  }

  void _isCorrectPass() {
    if (wrongPass) {
      _errorPassword();
    }
  }

  void _onPressed() {
    var password = textGrabber.text;
    if (password == '') {
      _emptyPassDialog();
      return;
    }
    _futureBuilder(password);
//    this.loginUser.login(widget.email, password).then((value) => print(value));
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    timeDilation = 1.0;
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
//                    Navigator.of(context).pop();
                    },
                  ),
                  InputPassword(
                      textGrabber,
                      focusNode: focusFirstNode
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
              child: BottomTitle('PASSWORD'),
            )]
        )
    );

  }
}