import 'package:flutter/material.dart';


class InputEmail extends StatelessWidget {
  const InputEmail({Key key, this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, left: 50, right: 50),
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: this.controller,
          style: TextStyle(
            fontFamily: 'nunito',
            color: Colors.lightBlue,
              fontSize: 20.0
          ),
          decoration: InputDecoration(
            border: new UnderlineInputBorder(
                borderSide: new BorderSide(
                color: Colors.red
                )
              ),
            fillColor: Colors.lightBlueAccent,
            labelText: 'E-mail',
            labelStyle: TextStyle(
              color: Color(0xff87a4d3),
              fontFamily: 'nunito',
              fontSize: 20.0
            ),
          ),
        ),
      ),
    );
  }
}