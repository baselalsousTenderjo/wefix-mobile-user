// To parse this JSON data, do
//
//     final timeAppoitmentModel = timeAppoitmentModelFromJson(jsonString);

import 'dart:convert';

TimeAppoitmentModel timeAppoitmentModelFromJson(String str) => TimeAppoitmentModel.fromJson(json.decode(str));

String timeAppoitmentModelToJson(TimeAppoitmentModel data) => json.encode(data.toJson());

class TimeAppoitmentModel {
    List<TimesList> timesList;

    TimeAppoitmentModel({
        required this.timesList,
    });

    factory TimeAppoitmentModel.fromJson(Map<String, dynamic> json) => TimeAppoitmentModel(
        timesList: List<TimesList>.from(json["timesList"].map((x) => TimesList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "timesList": List<dynamic>.from(timesList.map((x) => x.toJson())),
    };
}

class TimesList {
    String time;
    bool status;

    TimesList({
        required this.time,
        required this.status,
    });

    factory TimesList.fromJson(Map<String, dynamic> json) => TimesList(
        time: json["time"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "time": time,
        "status": status,
    };
}
