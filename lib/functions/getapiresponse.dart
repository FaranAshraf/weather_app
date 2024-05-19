import 'package:http/http.dart' as https;
import 'dart:convert';

import 'package:weather_app/Models/post_model.dart';
import 'package:weather_app/Models/post_future_weather_model.dart';
import 'package:weather_app/Models/post_time_model.dart';

Future<PostModel> getAPIresponse({required String cityname}) async {
  // TextEditingController citynamecontroller = TextEditingController();

  var url = Uri.parse(
      'https://api.weatherapi.com/v1/current.json?key=0351531532f54cad8d5195546242604&q=$cityname');
  var response = await https.get(url);
  var responseBody = jsonDecode(response.body);

  return PostModel.fromJson(responseBody);
}

Future<PostFutureModel> getfutureAPIresponse(
    {required String cityname, required String? date}) async {
  var url = Uri.parse(
      'https://api.weatherapi.com/v1/history.json?key=0351531532f54cad8d5195546242604&q=$cityname&dt=$date');
  var futureresponse = await https.get(url);
  var futureresponseBody = jsonDecode(futureresponse.body);

  return PostFutureModel.fromJson(futureresponseBody);
}

Stream<PostTimeModel> getTimeZones(
    {required String timeZone,
    Duration interval = const Duration(seconds: 1)}) async* {
  var url = Uri.parse("http://worldtimeapi.org/api/timezone/$timeZone");
  while (true) {
    var response = await https.get(url);

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      yield PostTimeModel.fromJson(responseBody);
    } else {
      throw Exception('Failed to load time zone data');
    }

    await Future.delayed(
        interval); // Wait for the specified interval before the next request
  }
}
