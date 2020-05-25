import 'package:flutter/material.dart';

class AcceptAlert extends StatelessWidget {
  const AcceptAlert({Key key, this.title, this.body, this.acceptPressed});
  final String title;
  final String body;
  final Function acceptPressed;

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
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Aceptar'),
            onPressed: () {
              Navigator.of(context).pop();
              this.acceptPressed();
            },
          ),
        ],
      );
  }}
