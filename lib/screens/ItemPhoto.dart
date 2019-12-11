import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class ItemPhoto extends StatefulWidget {
  String img;
  ItemPhoto({this.img, Key key}) : super(key: key);

  @override
  _ItemPhotoState createState() => _ItemPhotoState();
}

class _ItemPhotoState extends State<ItemPhoto> {
  Future<void> _shareImage() async {
    try {
      final ByteData bytes = await rootBundle.load(widget.img);
      await Share.file(
          'esys image', 'esys.png', bytes.buffer.asUint8List(), 'image/png',
          text: 'My optional text.');
    } catch (e) {
      print('error: $e');
    }
  }

  //Save
  void move() {
    rootBundle.load(widget.img).then((content) async {
      Directory dic = await getExternalStorageDirectory();
      // print(dic.absolute.path);
      var path = '${dic.absolute.path}/img.jpg';
      File newFile = File('${dic.absolute.path}/img.jpg');
      newFile.writeAsBytesSync(content.buffer.asUint8List());
      // visionImage = FirebaseVisionImage.fromFile(newFile);
      // _runAnalysis();
      Fluttertoast.showToast(
        msg: "Save Complete",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        fontSize: 16,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.img), fit: BoxFit.fill),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          print("share");
                          await _shareImage();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.add_event,
          closeManually: true,
          children: [
            SpeedDialChild(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                label: "Set as Wallpaper",
                onTap: () {}),
            SpeedDialChild(
                child: Icon(Icons.share, color: Colors.white),
                label: "Share",
                onTap: () async {
                  print("share");
                  await _shareImage();
                }),
            SpeedDialChild(
                child: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                label: "Save",
                onTap: () async {
                  await move();
                }),
          ],
        ),
      ),
    );
  }
}
