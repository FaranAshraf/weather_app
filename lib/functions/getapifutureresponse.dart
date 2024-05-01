import 'package:http/http.dart' as https;
import 'dart:convert';

getfutureAPIresponse({required String cityname}) async {
  // TextEditingController citynamecontroller = TextEditingController();

  var url = Uri.parse(
      'https://api.weatherapi.com/v1/future.json?key=0351531532f54cad8d5195546242604&q=$cityname&dt=2024-05-29');
  var futureresponse = await https.get(url);
  var futureresponseBody = jsonDecode(futureresponse.body);
  return futureresponseBody;
}
