class PostFutureModel {
  List? hour;

  PostFutureModel({required this.hour});
  PostFutureModel.fromJson(Map<String, dynamic> json) {
    hour = json['forecast']['forecastday'][0]['hour'];
  }
}
