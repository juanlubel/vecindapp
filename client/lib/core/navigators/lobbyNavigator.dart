import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:vecinapp/screens/user/apartment.dart';
import 'package:vecinapp/screens/user/dashboard.dart';
import 'package:vecinapp/screens/user/profile.dart';

enum NavigationEvents {
  DashboardClickedEvent,
  ProfileClickedEvent,
  ApartmentClickedEvent,
}

abstract class NavigationStates {}

class NavigationUser extends Bloc<NavigationEvents, NavigationStates> {
  final userBox = Hive.box('user');
  @override
  NavigationStates get initialState => DashboardScreen();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    int pk = userBox.get('pk');
    switch (event) {
      case NavigationEvents.DashboardClickedEvent:
        yield DashboardScreen();
        break;
      case NavigationEvents.ProfileClickedEvent:
        yield ProfileScreen();
        break;
      case NavigationEvents.ApartmentClickedEvent:
        yield ApartmentScreen(pk);
        break;
    }
  }
}