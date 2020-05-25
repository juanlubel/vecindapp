import 'package:flutter/material.dart';

class InputPassword extends StatefulWidget {
  InputPassword(this.controller, {Key key, this.focusNode = false}) : super(key: key);
  final TextEditingController controller;
  final bool focusNode;
  @override
  _InputPasswordState createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool _showPassword = false;

  FocusNode focusPassword;

  @override
  void initState() {
    super.initState();

    focusPassword = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.focusNode) {
      focusPassword.requestFocus();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 35, left: 50, right: 50),
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          controller: widget.controller,
          style: TextStyle(
              fontFamily: 'nunito',
              color: Colors.lightBlue,
              fontSize: 20.0
          ),
          focusNode: focusPassword,
          obscureText: !_showPassword,
          decoration: InputDecoration(
            border: new UnderlineInputBorder(
                borderSide: new BorderSide(
                    color: Colors.red
                )
            ),
            fillColor: Colors.lightBlueAccent,
            labelText: 'Password',
            labelStyle: TextStyle(
                color: Color(0xff87a4d3),
                fontFamily: 'nunito',
                fontSize: 20.0
            ),
            suffixIcon: IconButton(
                icon: Icon(
                    Icons.remove_red_eye,
                    color: this._showPassword ? Colors.blueAccent : Colors.blueGrey
                ),
                onPressed: () => setState(() {
                  _showPassword = !_showPassword;
                  }
                )),
          ),
        ),
      ),
    );
  }
}