import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wheelmania/constants.dart';
import 'package:wheelmania/screens/home_screen.dart';
import 'package:wheelmania/services/network_services.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  List<dynamic> _brandNamesList;
  TextStyle _loadingTextStyle;

  @override
  void initState() {
    super.initState();
    _loadingTextStyle = GoogleFonts.getFont(
      "Dancing Script",
      textStyle: TextStyle(
        fontSize: 35.0,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
      ),
    );
    loadDataToHomePage();
  }

  void loadDataToHomePage() async {
    NetworkHelper net = NetworkHelper();
    _brandNamesList = await net.getBikeBrandData();
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        builder: (context) => Home(
          brandNamesList: _brandNamesList,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = getDeviceHeight(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: deviceHeight * 0.10,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    IconTheme(
                      data: IconThemeData(
                          color: Theme.of(context)
                              .iconTheme
                              .color
                              .withOpacity(0.8),
                          size: 60.0),
                      child: FaIcon(FontAwesomeIcons.motorcycle),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      "Wheel Mania",
                      textAlign: TextAlign.center,
                      style: _loadingTextStyle.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .body1
                            .color
                            .withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.1,
              ),
              SpinKitPulse(
                color: Theme.of(context).iconTheme.color,
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
