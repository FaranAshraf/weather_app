class PostModel {
  String? date;
  String? city;
  String? country;
  double? temp;
  String? icon;
  double? speed;
  String? condition;

  PostModel(
      {required this.date,
      required this.city,
      required this.country,
      required this.temp,
      required this.icon,
      required this.speed,
      required this.condition});
  PostModel.fromJson(Map<String, dynamic> json) {
    date = json['location']['localtime'];
    city = json['location']['name'];
    country = json['location']['country'];
    temp = json['current']['temp_c'];
    icon = json['current']['condition']['icon'];
    speed = json['current']['wind_mph'];
    condition = json['current']['condition']['text'];
  }
}
