import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vecinapp/core/models/community.dart';
import 'package:vecinapp/core/navigators/lobbyNavigator.dart';
import 'package:vecinapp/core/services/community.service.dart';
import 'package:vecinapp/widgets/homeImage.dart';
import 'package:vecinapp/widgets/notificationAlert.dart';


class DashboardScreen extends StatefulWidget with NavigationStates  {

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<List<Community>> futureCommunities;
  CommunityService communityService = new CommunityService();

  @override
  void initState() {
    super.initState();
    futureCommunities = communityService.getCommunitiesByUser();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xff87a4d3), Colors.white70]),
      ),
      child: FutureBuilder<List<Community>>(
        future: futureCommunities,
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
              print(snapshot.data);
              return DashboardWidget(snapshot.data);
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
        },
      ),
    );
  }
}

class DashboardWidget extends StatelessWidget {
  DashboardWidget(this.communities);
  final List<Community> communities;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xff87a4d3), Colors.white70]),
      ),
      child: communities.length > 0 ? ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: communities.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20.0),
            child: Card(
                child: CardCommunityWidget(communities[index])),
          );
        }
      ) : Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Align(
            alignment: Alignment.center,
            child: Card(
                child: Text('CREA UNA VIVIENDA \n\n ACCEDE AL MENÚ \n\n -> MIS VIVIENDAS'),
            ),
          ),
        )
      )

    );
  }
}

class CardCommunityWidget extends StatelessWidget {
  CardCommunityWidget(this.community);
  final Community community;
  final userBox = Hive.box('user');


  Future<void> _openSettings(context) async {
    print(community.president.pk);
    var pk = await userBox.get('pk');
    print(pk);
    if (community.president.pk != pk) {
      return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return NotificationAlert(
                title: 'Presidente',
                body: 'No eres el presidente'
            );
          }
      );
    } else {
      return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return NotificationAlert(
                title: 'Presidente',
                body: 'Eres el presidente'
            );
          }
      );
    }
  }

  Future<void> _viviendasScreen(context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return NotificationAlert(
              title: 'Viviendas',
              body: 'Viviendas Screen'
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: double.infinity,
                height: 75,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.indigo, Colors.indigoAccent]),
                  ),
                  child: Text(
                    community.name,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 75,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Viviendas',
                      style: TextStyle(
                        fontSize: 24,
                        )
                      ),
                    FloatingActionButton(
                      backgroundColor: Color(0xff87a4d3),
                      onPressed: () {_viviendasScreen(context);},
                      child: Text(
                        community.apartments.length.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70
                        ),
                      ),
                    )
                    ],
                  ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 25,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Muro',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
            Divider(
              height: 64,
              thickness: 0.5,
              color: Colors.blueAccent.withOpacity(0.3),
              indent: 32,
              endIndent: 32,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 220.0),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverFixedExtentList(
                itemExtent: 100.0,
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.lightBlue[100 * (index % 9)],
                      child: Text('Mensaje $index'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: GestureDetector(
              onTap: () {_openSettings(context);},
              child: Icon(
                Icons.settings,
                color: Colors.blueGrey,
              )),
          ),
        )
      ],
    );
  }
}