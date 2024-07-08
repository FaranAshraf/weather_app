import 'package:intl/intl.dart';

class PostTimeModel {
  String? dateTime;
  String? offset;
  DateTime? now;
  String? time;

  PostTimeModel({this.dateTime, this.offset, this.now, this.time});

  PostTimeModel.fromJson(Map<String, dynamic> json) {
    dateTime = json['datetime'];
    offset = json['utc_offset'];

    if (dateTime != null && offset != null) {
      try {
        now = DateTime.parse(dateTime!).toUtc();

        final sign = offset![0]; // '+' or '-'
        final hours = int.parse(offset!.substring(1, 3));
        final minutes = int.parse(offset!.substring(4, 6));

        final duration = Duration(
          hours: hours,
          minutes: minutes,
        );

        now = sign == '+' ? now!.add(duration) : now!.subtract(duration);
        time = DateFormat('hh:mm:ss a').format(now!);
      } catch (e) {
        // Handle parsing errors
        print('Error parsing date/time: $e');
      }
    }
  }
}
