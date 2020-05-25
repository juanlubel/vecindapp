import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vecinapp/core/navigators/lobbyNavigator.dart';
import 'package:vecinapp/screens/sidebar/sidebar.dart';

class SideBarLayout extends StatelessWidget {
  SideBarLayout(this.email);
  final email;
  @override
  Widget build(BuildContext context) {
    debugPrint('lobby');
    debugPrint(this.email);
    return Scaffold(
      body: BlocProvider<NavigationUser>(
        create: (context) => NavigationUser(),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationUser, NavigationStates>(
              builder: (context, navigationState) {
                return navigationState as Widget;
              },
            ),
            SideBar(this.email),
          ],
        ),
      ),
    );
  }
}