import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vecinapp/widgets/homeImage.dart';

class LoaderScreen extends StatefulWidget {
  @override
  _LoaderScreenState createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xff87a4d3), Colors.white70]),
            ),
            padding: const EdgeInsets.only(top: 40.0),
            alignment: Alignment.topCenter,
            child: HomeImage(
              photo: 'assets/images/logo.gif',
              width: 150.0,
              onTap: () {},
            ),
        )
    );
  }
  }

