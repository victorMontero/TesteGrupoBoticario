import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste_gb/bloc/bottom_navbar_bloc.dart';
import 'package:teste_gb/bloc/feed_bloc.dart';
import 'package:teste_gb/bloc/home_bloc.dart';
import 'package:teste_gb/screens/feed_screen.dart';
import 'package:teste_gb/screens/login_screen.dart';
import 'package:teste_gb/screens/news_screen.dart';
import 'package:teste_gb/screens/post_screen.dart';
import 'package:teste_gb/style/theme.dart' as Style;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BottomNavBarBloc _bottomNavBarBloc;
  HomeBloc _homeBloc;
  FeedBloc _feedBloc;

  @override
  void initState() {
    super.initState();
    _bottomNavBarBloc = BottomNavBarBloc();
    _homeBloc = HomeBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(actions: [
          Padding( padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false),
              child: Icon(
                EvaIcons.logOutOutline
              ),
            ),
          )
        ],
          backgroundColor: Style.Colors.mainColor,
          title: Text(
            'boticapp',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<NavBarItem>(
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultItem,
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
            switch (snapshot.data) {
              case NavBarItem.NEWS:
                return NewsScreen();
              case NavBarItem.FEED:
                return FeedScreen();
            }
          },
        ),
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[100], spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                iconSize: 20,
                unselectedItemColor: Style.Colors.grey,
                unselectedFontSize: 9.5,
                selectedFontSize: 9.5,
                type: BottomNavigationBarType.fixed,
                fixedColor: Colors.amberAccent,
                currentIndex: snapshot.data.index,
                onTap: _bottomNavBarBloc.pickItem,
                items: [
                  BottomNavigationBarItem(
                    title: Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text("feed",
                            style: TextStyle(fontSize: 12.0,
                                fontWeight: FontWeight.w600))),
                    icon: Icon(EvaIcons.homeOutline),
                    activeIcon: Icon(EvaIcons.home),
                  ),
                  BottomNavigationBarItem(
                    title: Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text("news",
                            style: TextStyle(fontSize: 12.0,
                                fontWeight: FontWeight.w600))),
                    icon: Icon(EvaIcons.globe2),
                    activeIcon: Icon(EvaIcons.globe2Outline),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


}
