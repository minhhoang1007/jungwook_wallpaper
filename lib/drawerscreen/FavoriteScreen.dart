import 'package:flutter/material.dart';
import 'package:jungkook_wallpaper/drawerscreen/drawer.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerSceen(),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 100, 400),
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
            icon: Icon(
              Icons.list,
              color: Colors.white,
            ),
            iconSize: 30,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Jungkook Wallpaper",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                "Favorite",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              )
            ],
          ),
        ),
        body: Container(
          child: Center(
            child: Text("No image"),
          ),
        ),
      ),
    );
  }
}
