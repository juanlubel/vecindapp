import 'package:flutter/material.dart';

class NotificationAlert extends StatelessWidget {
  const NotificationAlert({Key key, this.title, this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this.title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(this.body),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Aceptar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }}
