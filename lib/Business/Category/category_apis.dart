import 'dart:convert';
import 'dart:developer';

import 'package:wefix/Business/end_points.dart';
import 'package:wefix/Data/Api/http_request.dart';


class CategoryApis {


  // * Get All Category
  

  // * Get All Category
  static Future getColor({required String token}) async {
    try {
      final response = await HttpHelper.getData(
        query: EndPoints.color,
        token: token,
      );

      log('getColor() [ STATUS ] -> ${response.statusCode}');

      final body = json.decode(response.body);

      if (response.statusCode == 200) {
        log(body["color"]["websettingValue"]);

        return body["color"]["websettingValue"];
      } else {
        return [];
      }
    } catch (e) {
      log('getColor() [ ERROR ] -> $e');
      return [];
    }
  }

 
}
