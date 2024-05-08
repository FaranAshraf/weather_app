import 'package:http/http.dart' as https;
import 'dart:convert';

import 'package:weather_app/Models/post_future_weather_model.dart';

Future<PostFutureModel> getfutureAPIresponse(
    {required String cityname, String? date}) async {
  var url = Uri.parse(
      'https://api.weatherapi.com/v1/history.json?key=0351531532f54cad8d5195546242604&q=$cityname&dt=${date ?? '2024-05-04'}');
  var futureresponse = await https.get(url);
  var futureresponseBody = jsonDecode(futureresponse.body);

  return PostFutureModel.fromJson(futureresponseBody);
}
