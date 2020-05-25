import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vecinapp/core/models/users.dart';
import 'package:vecinapp/core/services/auth.service.dart';
import 'package:vecinapp/screens/password.dart';
import 'package:vecinapp/screens/register.dart';

import 'loader.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  String email;

  LoginScreen(this.email);

  HomeService homeService = HomeService();
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<User>(
      future: homeService.login(this.email),
      builder: (context, snapshot) {
        print(snapshot);
        if (snapshot.hasData) {
          if (snapshot.data.pk != null) {
            return PasswordScreen(email: this.email);
          }
        }
        if (snapshot.hasError){
          var res = snapshot.error;
          if (res == 404) {
            return RegisterScreen(email: this.email);
          }
        }
        return LoaderScreen();
      },
    );
  }
}



