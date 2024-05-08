import 'package:http/http.dart' as https;
import 'dart:convert';

import 'package:weather_app/Models/post_model.dart';

Future<PostModel> getAPIresponse({required String cityname}) async {
  // TextEditingController citynamecontroller = TextEditingController();

  var url = Uri.parse(
      'https://api.weatherapi.com/v1/current.json?key=0351531532f54cad8d5195546242604&q=$cityname');
  var response = await https.get(url);
  var responseBody = jsonDecode(response.body);
  return PostModel.fromJson(responseBody);
}
