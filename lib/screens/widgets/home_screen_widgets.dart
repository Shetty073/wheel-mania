import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wheelmania/constants.dart';
import 'package:wheelmania/services/network_services.dart';
import 'package:wheelmania/screens/list_bikes_by_brand.dart';

class HomeBody extends StatefulWidget {
  HomeBody({
    @required this.context,
    @required this.brandNamesList,
  });

  final BuildContext context;
  final List<dynamic> brandNamesList;

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<dynamic> _brandNamesList;
  final List colorsList = kAppColorsList;

  @override
  void initState() {
    super.initState();
    _brandNamesList = widget.brandNamesList;
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _brandNamesList.length,
      itemBuilder: (context, position) {
        return PageViewCards(
          cardInfoList: _brandNamesList,
          index: position,
          colors: colorsList,
        );
      },
    );
  }
}

// Horizontal card view
class PageViewCards extends StatelessWidget {
  const PageViewCards({
    Key key,
    @required this.cardInfoList,
    @required this.index,
    @required this.colors,
  }) : super(key: key);

  final List<dynamic> cardInfoList;
  final int index;
  final List colors;

  void _updateOnTap(BuildContext context, String brandName, List colors) async {
    NetworkHelper net = NetworkHelper();
    var bName = brandName.replaceAll(" ", "_");
    bName = "${bName.toLowerCase()}_bikes";
    List bikeSpecs = await net.getBikeSpecsByBrand(bName);
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ListBikesByBrand(
          brandName: brandName,
          colors: colors,
          bikeSpecs: bikeSpecs,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Hero(
          tag: cardInfoList[index][0],
          transitionOnUserGestures: true,
          child: Material(
            type: MaterialType.transparency,
            child: Center(
              child: ClipPath(
                clipper: CharacterCardBackgroundClipper(),
                child: GestureDetector(
                  child: Container(
                    width: getDeviceWidth(context) * 0.80,
                    height: getDeviceHeight(context) * 0.75,
                    decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(25.0),
                      gradient: LinearGradient(
                        colors: colors[index % 2],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.3, 0.8],
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(top: 150.0),
                      child: Center(
                        child: Text(
                          cardInfoList[index][0],
                          style: TextStyle(
                            color: Theme.of(context).textTheme.body2.color,
                            fontSize: getDeviceWidth(context) * 0.15,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    _updateOnTap(
                        context, cardInfoList[index][0], colors[index % 2]);
                  },
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: getDeviceHeight(context) * 0.09,
          left: getDeviceWidth(context) * 0.17,
          child: CachedNetworkImage(
            imageUrl: cardInfoList[index][1],
          ),
        ),
      ],
    );
  }
}

class CharacterCardBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var roundnessFactor = 50.0;

    path.moveTo(0, size.height * 0.33);
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(0, size.height, roundnessFactor, size.height);
    path.lineTo(size.width - roundnessFactor, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - roundnessFactor);
    path.lineTo(size.width, roundnessFactor * 2);
    path.quadraticBezierTo(size.width, 0, size.width - roundnessFactor * 2.27,
        roundnessFactor * 2);
    path.lineTo(roundnessFactor, size.height * 0.33 + 4);
    path.quadraticBezierTo(0, size.height * 0.33 + roundnessFactor, 0,
        size.height * 0.33 + roundnessFactor * 2);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
