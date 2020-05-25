import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vecinapp/core/models/apartment.dart';
import 'package:vecinapp/core/models/community.dart';
import 'package:vecinapp/core/services/community.service.dart';
import 'package:vecinapp/widgets/homeImage.dart';

class ApartmentCreateForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var newApartment = new Apartment(pk: -1);
    return ApartmentFormWidget(newApartment);
  }
}

class ApartmentForm extends StatefulWidget {
  ApartmentForm(this.pk);
  final int pk;

  @override
  _ApartmentFormState createState() => _ApartmentFormState();
}

class _ApartmentFormState extends State<ApartmentForm> {
  final CommunityService communityService = CommunityService();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xff87a4d3), Colors.white70]),
      ),
      child: FutureBuilder(
          future: communityService.getApartmentByPk(widget.pk),
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
                debugPrint(widget.pk.toString());
                print(snapshot);
                return ApartmentFormWidget(snapshot.data);
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
}

class ApartmentFormWidget extends StatefulWidget {
  final Apartment apartment;
  ApartmentFormWidget(this.apartment);

  @override
  _ApartmentFormWidgetState createState() => _ApartmentFormWidgetState();
}

class _ApartmentFormWidgetState extends State<ApartmentFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _puertaController = TextEditingController();
  final _pisoController = TextEditingController();
  bool create;
  List<CommunityEmbedded> communityOptions = [];
  int communitySelected;
  final CommunityService communityService = CommunityService();

  @override
  void dispose() {
    _puertaController.dispose();
    _pisoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    create = widget.apartment.pk == -1;
    if (!create) {
      _getCommunityOptions();
      _valuesFromApartment();
    }
    _getCommunityOptions();

    super.initState();
  }

  void _valuesFromApartment() {
    _puertaController.text = widget.apartment.puerta;
    _pisoController.text = widget.apartment.piso.toString();
  }

  Future _updateApartment() {
    widget.apartment.puerta = _puertaController.text;
    widget.apartment.piso = int.parse(_pisoController.text);
    communityService.updateApartment(widget.apartment).then((value)
    {
      Navigator.of(context).pop(value);
    }
    );
  }

  Future _createApartment() {
    widget.apartment.puerta = _puertaController.text;
    widget.apartment.piso = int.parse(_pisoController.text);
    if (communitySelected != null) {
      communityService.createApartment(widget.apartment, communitySelected).then((value)
      {
        Navigator.of(context).pop(value);
      }
      );
    }
  }

  Future _getCommunityOptions() async {
    await communityService.getCommunities().then((value) {
      debugPrint('Future Options');
      print(value);
      print(widget.apartment.community);
      print(value.contains(widget.apartment.community));
      setState(() {
        communityOptions = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xff87a4d3), Colors.white70]),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _pisoController,
                      decoration: InputDecoration(
                          labelText: 'Piso de la vivienda',
                          hintText: 'ej: 1, 2 ... 25 '
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ], // Only n
                    ),
                    TextField(
                      controller: _puertaController,
                      decoration: InputDecoration(
                          labelText: 'Puerta de la vivienda',
                          hintText: 'ej: 16 ó 2D'
                      ),
                    ),
                    communityOptions.length > 0 ? DropdownButtonFormField(
                      iconSize: 40,
                      isExpanded: true,
                      hint: Text('Selecciona tu comunidad'),
                      items: communityOptions
                          .map<DropdownMenuItem<CommunityEmbedded>>((CommunityEmbedded e) {
                        return DropdownMenuItem<CommunityEmbedded>(
                            child: Text(e.name),
                            value: e
                        );
                      }
                      ).toList(),
                      onChanged: (CommunityEmbedded value) {
                        communitySelected = value.pk;
                      },
                    ) : Center(child: CircularProgressIndicator(),),

                  ]
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(25)
                ),
                child: FlatButton.icon(
                    onPressed: () {
                      if (create) {
                        _createApartment();
                      } else {
                        _updateApartment();
                      }

                    },
                    icon: Icon(Icons.border_color),
                    label: Text(create ? 'Crear Vivienda' : 'Modificar Vivienda'),

                ),
              )

            )
          ],
        )
      ),
    );
  }
}