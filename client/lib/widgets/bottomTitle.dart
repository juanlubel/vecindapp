import 'package:flutter/material.dart';

class BottomTitle extends StatelessWidget{
  final String title;
  BottomTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, bottom: 10),
      child: Text(
        this.title,
        style: TextStyle(
            fontSize: 37,
            backgroundColor: Colors.white.withOpacity(0.0)
        ),
      ),
    );
  }

}