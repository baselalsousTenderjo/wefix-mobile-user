// To parse this JSON data, do
//
//     final holidayModel = holidayModelFromJson(jsonString);

import 'dart:convert';

HolidayModel holidayModelFromJson(String str) =>
    HolidayModel.fromJson(json.decode(str));

String holidayModelToJson(HolidayModel data) => json.encode(data.toJson());

class HolidayModel {
  List<Holiday> holidays;

  HolidayModel({
    required this.holidays,
  });

  factory HolidayModel.fromJson(Map<String, dynamic> json) => HolidayModel(
        holidays: List<Holiday>.from(
            json["holidays"].map((x) => Holiday.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "holidays": List<dynamic>.from(holidays.map((x) => x.toJson())),
      };
}

class Holiday {
  int id;
  String title;
  String date;
  DateTime createdDate;

  Holiday({
    required this.id,
    required this.title,
    required this.date,
    required this.createdDate,
  });

  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
        id: json["id"],
        title: json["title"],
        date: json["date"],
        createdDate: DateTime.parse(json["createdDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "date": date,
        "createdDate": createdDate.toIso8601String(),
      };
}
