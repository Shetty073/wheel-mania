import 'package:http/http.dart' as http;
import 'package:wheelmania/constants.dart';
import 'dart:convert';

class NetworkHelper {

  Future getBikeBrandData() async {
    var url = kApiUrl + "all_bike_brands";
    var resp = await http.get(url);
    return jsonDecode(resp.body);
  }

  Future getBikeSpecsByBrand(String brandName) async {
    var url = kApiUrl + "specs_by_brand/$brandName";
    var resp = await http.get(url);
    return jsonDecode(resp.body);
  }

}
