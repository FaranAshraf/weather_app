import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'dart:convert';

import 'package:weather_app/Models/post_model.dart';
import 'package:weather_app/Models/post_future_weather_model.dart';

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

void fetchData() async {
  String cityName = 'YourCityName';

  // Fetch current weather data
  PostModel currentWeather = await getAPIresponse(cityname: cityName);

  // Extract date from current weather data
  String? currentDate = currentWeather.date;

  // Fetch future weather data using the obtained date
  PostFutureModel futureWeather = await getfutureAPIresponse(
    cityname: cityName,
    date: currentDate,
  );
}
