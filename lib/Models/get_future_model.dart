class GetFutureModel {
  List<dynamic>? hour;

  GetFutureModel({this.hour});

  GetFutureModel.fromJson(Map<String, dynamic> json) {
    hour = json['forecast']['forecastday'][0]['hour'];
  }
}
