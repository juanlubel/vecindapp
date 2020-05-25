import 'package:flutter/material.dart';
import 'package:vecinapp/core/navigators/lobbyNavigator.dart';

class ProfileScreen extends StatelessWidget with NavigationStates  {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Profile",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}