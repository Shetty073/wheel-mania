import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wheelmania/constants.dart';
import 'package:screenshot/screenshot.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpecsPage extends StatefulWidget {
  SpecsPage({@required this.bikeSpecs, @required this.colors});

  final Map bikeSpecs;
  final List colors;

  @override
  _SpecsPageState createState() => _SpecsPageState();
}

class _SpecsPageState extends State<SpecsPage> {
  ScreenshotController screenshotController = ScreenshotController();

  Map _bikeSpecs;
  List _colors;
  String _imgUrl;
  String _bikeName;

  @override
  void initState() {
    super.initState();
    _bikeSpecs = new Map();
    _bikeSpecs = widget.bikeSpecs;
    _colors = widget.colors;
    _imgUrl = _bikeSpecs["bike_picture"];
    _bikeName =
        "${_bikeSpecs["model_name"][0].toUpperCase()}${_bikeSpecs["model_name"].substring(1)}";
  }

  List<Widget> displayData(map) {
    List<Widget> dataItems = [];
    dataItems.add(
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _bikeName,
              style: TextStyle(
                color: Theme.of(context).textTheme.body2.color,
                fontSize: getDeviceWidth(context) * 0.07,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        margin: EdgeInsets.only(top: 15.0, bottom: 14.0),
      ),
    );
    map.forEach((key, value) {
      if (key != "bike_picture" && key != "model_name") {
        var newKey = "${key[0].toUpperCase()}${key.substring(1)}";
        newKey = newKey.replaceAll("_", " ");
        dataItems.add(getDataRow(newKey, value));
      }
    });
    dataItems.add(
      CachedNetworkImage(
        imageUrl: _imgUrl,
        imageBuilder: (context, imageProvider) => Container(
          margin:
              EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0, bottom: 30.0),
          width: getDeviceWidth(context) * 0.80,
          height: getDeviceWidth(context) * 0.50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => SpinKitPulse(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
    return dataItems;
  }

  Widget getDataRow(String key, String value) {
    return Container(
      height: getDeviceWidth(context) * 0.05,
      margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          Text(
            "$key :",
            style: TextStyle(
              color: Theme.of(context).textTheme.body2.color,
              fontSize: getDeviceWidth(context) * 0.045,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Text(
              "$value",
              style: TextStyle(
                color: Theme.of(context).textTheme.body2.color,
                fontSize: getDeviceWidth(context) * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconTheme(
          data: IconThemeData(
            color: Colors.white,
          ),
          child: IconButton(
            icon: FaIcon(FontAwesomeIcons.times),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: _colors[0],
        actions: <Widget>[
          IconTheme(
            data: IconThemeData(
              color: Colors.white,
            ),
            child: IconButton(
              icon: FaIcon(FontAwesomeIcons.shareAlt),
              onPressed: () {
                screenshotController
                    .capture(delay: Duration(milliseconds: 10))
                    .then((File image) async {
                  final Uint8List bytes = image.readAsBytesSync();
                  await Share.file("Specs for $_bikeName", "$_bikeName.png",
                      bytes, "image/png");
                }).catchError((onError) {
                  print(onError);
                });
              },
            ),
          ),
        ],
      ),
      body: Hero(
        tag: _bikeName,
        child: Material(
          type: MaterialType.transparency,
          child: Screenshot(
            controller: screenshotController,
            child: Container(
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.2, 0.9],
                ),
              ),
              child: ListView(
                children: displayData(_bikeSpecs),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
