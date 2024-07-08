class GetWeatherModel {
  String? city;
  String? country;
  double? temp;
  String? icon;
  double? speed;
  String? condition;
  String? timeZone;
  DateTime? trueDate;

  GetWeatherModel({
    this.city,
    this.country,
    this.temp,
    this.icon,
    this.speed,
    this.condition,
    this.timeZone,
    this.trueDate,
  });

  GetWeatherModel.fromJson(Map<String, dynamic> json) {
    city = json["location"]["name"];
    country = json["location"]["country"];
    temp = (json["current"]["temp_c"] as num?)?.toDouble();
    icon = json["current"]["condition"]["icon"];
    speed = (json["current"]["wind_mph"] as num?)?.toDouble();
    condition = json["current"]["condition"]["text"];
    timeZone = json["location"]["tz_id"];

    final localtimeStr = json["location"]["localtime"];
    if (localtimeStr != null) {
      trueDate = _parseDateTime(localtimeStr);
    }
  }

  DateTime? _parseDateTime(String dateStr) {
    try {
      // Ensure the date string is in the format "yyyy-MM-dd HH:mm:ss"
      if (RegExp(r'^\d{4}-\d{2}-\d{2} \d{1}:\d{2}$').hasMatch(dateStr)) {
        dateStr = dateStr.replaceFirst(RegExp(r' '), ' 0');
      } else if (RegExp(r'^\d{4}-\d{2}-\d{2} \d{1,2}:\d{2}:\d{2}$')
          .hasMatch(dateStr)) {
        dateStr = dateStr.replaceFirst(RegExp(r' '), ' 0');
      }
      return DateTime.parse(dateStr);
    } catch (e) {
      print('Error parsing date: $e');
      return null;
    }
  }
}
