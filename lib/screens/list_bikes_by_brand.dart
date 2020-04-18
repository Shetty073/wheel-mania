import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wheelmania/constants.dart';
import 'package:wheelmania/screens/specs_page.dart';

class ListBikesByBrand extends StatefulWidget {
  ListBikesByBrand(
      {@required this.brandName,
      @required this.colors,
      @required this.bikeSpecs});

  final String brandName;
  final List colors;
  final List bikeSpecs;

  @override
  _ListBikesByBrandState createState() => _ListBikesByBrandState();
}

class _ListBikesByBrandState extends State<ListBikesByBrand> {
  String _brandName;
  List _colors;
  List _bikeSpecs;

  @override
  void initState() {
    super.initState();
    _brandName = widget.brandName;
    _colors = widget.colors;
    _bikeSpecs = widget.bikeSpecs;
  }

  void _updateOnTap(List colors, Map bikeSpecs) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => SpecsPage(
          bikeSpecs: bikeSpecs,
          colors: colors,
        ),
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
            icon: FaIcon(FontAwesomeIcons.angleLeft),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: _colors[0],
      ),
      body: ListView.builder(
        itemCount: _bikeSpecs.length + 1,
        itemBuilder: (context, index) {
          return index == 0
              ? Hero(
                  tag: _brandName,
                  transitionOnUserGestures: true,
                  child: Material(
                    type: MaterialType.transparency,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 0.0, bottom: 20.0, right: 0.0, left: 0.0),
                      width: getDeviceWidth(context) * 0.60,
                      height: getDeviceHeight(context) * 0.20,
                      child: Center(
                        child: Text(
                          "$_brandName Bikes",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.body2.color,
                            fontSize: getDeviceWidth(context) * 0.10,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.zero,
                        gradient: LinearGradient(
                          colors: _colors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.5, 0.9],
                        ),
                      ),
                    ),
                  ),
                )
              : GestureDetector(
                  child: Hero(
                    tag: "${_bikeSpecs[index - 1]["model_name"][0].toUpperCase()}${_bikeSpecs[index - 1]["model_name"].substring(1)}",
                    child: Material(
                      type: MaterialType.transparency,
                      child: Container(
                        margin: EdgeInsets.all(15.0),
                        width: getDeviceWidth(context) * 0.60,
                        height: getDeviceHeight(context) * 0.20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          gradient: LinearGradient(
                            colors: _colors,
                            stops: [0.1, 0.8],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "${_bikeSpecs[index - 1]["model_name"][0].toUpperCase()}${_bikeSpecs[index - 1]["model_name"].substring(1)}",
                            style: TextStyle(
                              color: Theme.of(context).textTheme.body2.color,
                              fontSize: getDeviceWidth(context) * 0.06,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    _updateOnTap(_colors, _bikeSpecs[index - 1]);
                  },
                );
        },
      ),
    );
  }
}
