import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class Ecard1 extends StatefulWidget {
  const Ecard1({Key? key}) : super(key: key);

  @override
  State<Ecard1> createState() => _Ecard1State();
}

class _Ecard1State extends State<Ecard1> {
  bool vis = true;
  final GlobalKey _key = GlobalKey();
  final fieldText = TextEditingController();

  void _CaptureScreenShot() async {
//get paint bound of your app screen or the widget which is wrapped with RepaintBoundary.
    RenderRepaintBoundary bound =
        _key.currentContext!.findRenderObject() as RenderRepaintBoundary;

    if (bound.debugNeedsPaint) {
      Timer(Duration(seconds: 1), () => _CaptureScreenShot());
      return null;
    }

    ui.Image image = await bound.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

// this will save image screenshot in gallery
    if (byteData != null) {
      final path1 = await getApplicationDocumentsDirectory();
      String p = path1.path;
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final resultsave = await ImageGallerySaver.saveImage(
          Uint8List.fromList(pngBytes),
          quality: 90,
          name: 'screenshot-${DateTime.now()}.png');
      print(" tttt $resultsave");
      print(" tt $p/screenshot-${DateTime.now()}.png");
    }
  }

  @override
  Widget build(BuildContext context) {
//Here i have wrapped whole app screen scaffold widget, to take full screenshot
    return RepaintBoundary(
      key: _key,
      child: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //   color: Colors.blue,
              height: 650,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/w11.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 120),
                  Text(
                    'Save The Date',
                    style: TextStyle(
                        fontSize: 20.0, height: 2.0, color: Colors.teal),
                  ),
                  Text(
                    'The Love Story Of ',
                    style: TextStyle(
                        fontSize: 18.0, height: 2.0, color: Colors.blueGrey),
                  ),
                  TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25.0, height: 2.0, color: Colors.black),
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Bride name',
                        hintStyle: TextStyle(color: Colors.grey),
                      )),
                  Text(
                    'And',
                    style: TextStyle(
                        fontSize: 10.0, height: 2.0, color: Colors.teal),
                  ),
                  TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25.0, height: 2.0, color: Colors.black),
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Bidegroom name',
                        hintStyle: TextStyle(color: Colors.grey),
                      )),
                  Text(
                    'On',
                    style: TextStyle(
                        fontSize: 15.0, height: 2.0, color: Colors.teal),
                  ),
                  TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 5.0, height: 2.0, color: Colors.grey),
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Date',
                        hintStyle: TextStyle(color: Colors.grey),
                      )),
                  Text(
                    'please join us at',
                    style: TextStyle(
                        fontSize: 5.0, height: 2.0, color: Colors.grey),
                  ),
                  TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 5.0, height: 2.0, color: Colors.grey),
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'clock',
                        hintStyle: TextStyle(color: Colors.grey),
                      )),
                  Text(
                    'In',
                    style: TextStyle(
                        fontSize: 20.0, height: 2.0, color: Colors.teal),
                  ),
                  TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 5.0, height: 2.0, color: Colors.grey),
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Venue name',
                        hintStyle: TextStyle(color: Colors.grey),
                      )),
                ],
              ),
            ),
            Visibility(
              visible: vis,
              child: ElevatedButton(
                  onPressed: () {
                    vis = false;
                    setState(() {});
                    _CaptureScreenShot(); // Method called to take screenshot on wrapped widget and save it.
                  },
                  child: Text("Save")),
            )
          ],
        )),
      ),
    );
  }
}
