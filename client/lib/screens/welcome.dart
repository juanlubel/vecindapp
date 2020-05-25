import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:vecinapp/widgets/homeImage.dart';

class WelcomeScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    timeDilation = 1.0; // 1.0 means normal animation speed.

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xff87a4d3), Colors.white70]),
        ),
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        child: HomeImage(
          photo: 'assets/images/home_logo.png',
          width: 300.0,
          onTap: () {
            Navigator.of(context).pushNamed(
                '/home'
                );
          },
        ),
      ),
    );
  }
}