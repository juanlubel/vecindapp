import 'package:flutter/material.dart';
import 'package:vecinapp/routes.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('user');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'nunito',
            primarySwatch: Colors.lightBlue,
            textTheme: TextTheme(
                headline1: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14.5
                ),
              bodyText1: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14.5
              ),
            ),

        ),
        onGenerateRoute: routes()
    );
  }
}