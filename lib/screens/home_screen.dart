import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wheelmania/constants.dart';
import 'package:wheelmania/screens/widgets/home_screen_widgets.dart';

class Home extends StatefulWidget {
  Home({@required this.brandNamesList,});

  final List<dynamic> brandNamesList;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> _brandNamesList;
  @override
  void initState() {
    super.initState();
    _brandNamesList = widget.brandNamesList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Wheel Mania",
          style: GoogleFonts.getFont(
            "Dancing Script",
            textStyle: TextStyle(
              color: Theme.of(context).textTheme.body1.color,
              fontSize: getDeviceHeight(context) * 0.0256,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        actions: <Widget>[
          IconTheme(
            data: IconThemeData(
              color: Theme.of(context).iconTheme.color.withOpacity(0.8),
              size: getDeviceHeight(context) * 0.035,
            ),
            child: IconButton(
              icon: FaIcon(FontAwesomeIcons.cog),
              onPressed: () {
                // Go to settings
              },
            ),
          ),
        ],

      ),
      body: HomeBody(
        context: context,
        brandNamesList: _brandNamesList,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
