import 'package:intl/intl.dart';

class PostTimeModel {
  String dateTime;
  String offset;
  DateTime? now;
  String? time;

  PostTimeModel({
    required this.dateTime,
    required this.offset,
  }) {
    now = DateTime.parse(dateTime);

    now = now!.add(Duration(hours: int.parse(offset.substring(1, 3))));

    time = DateFormat.jms().format(now!);
  }

  factory PostTimeModel.fromJson(Map<String, dynamic> json) {
    return PostTimeModel(
      dateTime: json['datetime'],
      offset: json['utc_offset'], // Assuming the correct key is 'utc_offset'
    );
  }
}
