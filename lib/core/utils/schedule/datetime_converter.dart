import 'package:freezed_annotation/freezed_annotation.dart';

class DatetimeConverter implements JsonConverter<DateTime, String> {
  const DatetimeConverter();

  @override
  DateTime fromJson(String json) {
    if (json.length == 12) {
      int year = int.parse(json.substring(0, 4));
      int month = int.parse(json.substring(4, 6));
      int day = int.parse(json.substring(6, 8));
      int hour = int.parse(json.substring(8, 10));
      int minute = int.parse(json.substring(10, 12));
      return DateTime(year, month, day, hour, minute);
    } else {
      throw FormatException('Invalid date time format: $json');
    }
  }

  @override
  String toJson(DateTime dateTime) {
    return '${dateTime.year}${dateTime.month.toString().padLeft(2, '0')}${dateTime.day.toString().padLeft(2, '0')}${dateTime.hour.toString().padLeft(2, '0')}${dateTime.minute.toString().padLeft(2, '0')}';
  }
}