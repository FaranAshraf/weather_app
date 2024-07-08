import 'dart:async';
import 'package:http/http.dart' as https;
import 'package:weather_app/Models/get_future_model.dart';
import 'package:weather_app/Models/get_weather_model.dart';
import 'dart:convert';
import 'package:weather_app/Models/post_time_model.dart';

Future<GetWeatherModel> getAPIresponse({required String cityname}) async {
  var url = Uri.parse(
      'https://api.weatherapi.com/v1/current.json?key=03e5c5dfc51f452bb87204122241905&q=$cityname&aqi=yes');
  var response = await https.get(url);

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    return GetWeatherModel.fromJson(responseBody);
  } else {
    throw Exception('Failed to load weather data');
  }
}

Future<GetFutureModel> getfutureAPIresponse(
    {required String cityname, required String? date}) async {
  var url = Uri.parse(
      'https://api.weatherapi.com/v1/history.json?key=03e5c5dfc51f452bb87204122241905&q=$cityname&dt=$date');
  var futureresponse = await https.get(url);

  if (futureresponse.statusCode == 200) {
    var futureresponseBody = jsonDecode(futureresponse.body);
    return GetFutureModel.fromJson(futureresponseBody);
  } else {
    throw Exception('Failed to load future weather data');
  }
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

    await Future.delayed(interval);
  }
}
