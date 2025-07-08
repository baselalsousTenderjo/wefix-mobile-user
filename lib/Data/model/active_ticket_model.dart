// To parse this JSON data, do
//
//     final activeTicketModel = activeTicketModelFromJson(jsonString);

import 'dart:convert';

ActiveTicketModel activeTicketModelFromJson(String str) =>
    ActiveTicketModel.fromJson(json.decode(str));

String activeTicketModelToJson(ActiveTicketModel data) =>
    json.encode(data.toJson());

class ActiveTicketModel {
  List<Ticket> tickets;

  ActiveTicketModel({
    required this.tickets,
  });

  factory ActiveTicketModel.fromJson(Map<String, dynamic> json) =>
      ActiveTicketModel(
        tickets:
            List<Ticket>.from(json["tickets"].map((x) => Ticket.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tickets": List<dynamic>.from(tickets.map((x) => x.toJson())),
      };
}

class Ticket {
  int id;
  int customerId;
  int ticketTypeId;
  DateTime requestedDate;
  DateTime selectedDate;
  String selectedDateTime;
  DateTime timeFrom;
  DateTime timeTo;
  String? teamNo;
  String? status;
  String? location;
  String? longitude;
  String? latitude;
  String? gender;
  bool isWithMaterial;
  String? priority;
  int createdBy;
  int customerPackageId;
  dynamic totalPrice;
  String? promoCode;
  dynamic serviceprovide;
  dynamic serviceprovideImage;
  String? description;
  String? descriptionAr;
  String? qrCodePath;
  int rating;
  bool isRated;
  String? qrCode;
  String? statusAr;
  dynamic process;

  Ticket({
    required this.id,
    required this.customerId,
    required this.ticketTypeId,
    required this.requestedDate,
    required this.selectedDate,
    required this.selectedDateTime,
    required this.timeFrom,
    required this.timeTo,
    required this.teamNo,
    required this.status,
    required this.location,
    required this.longitude,
    required this.latitude,
    required this.gender,
    required this.isWithMaterial,
    required this.priority,
    required this.createdBy,
    required this.customerPackageId,
    required this.totalPrice,
    required this.promoCode,
    required this.serviceprovide,
    required this.serviceprovideImage,
    required this.description,
    required this.descriptionAr,
    required this.qrCodePath,
    required this.rating,
    required this.isRated,
    required this.qrCode,
    required this.statusAr,
    required this.process,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json["id"],
        customerId: json["customerId"],
        ticketTypeId: json["ticketTypeId"],
        requestedDate: DateTime.parse(json["requestedDate"]),
        selectedDate: DateTime.parse(json["selectedDate"]),
        selectedDateTime: json["selectedDateTime"],
        timeFrom: DateTime.parse(json["timeFrom"]),
        timeTo: DateTime.parse(json["timeTo"]),
        teamNo: json["teamNo"],
        status: json["status"],
        location: json["location"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        gender: json["gender"],
        isWithMaterial: json["isWithMaterial"],
        priority: json["priority"],
        createdBy: json["createdBy"],
        customerPackageId: json["customerPackageId"],
        totalPrice: json["totalPrice"],
        promoCode: json["promoCode"],
        serviceprovide: json["serviceprovide"],
        serviceprovideImage: json["serviceprovideImage"],
        description: json["description"],
        descriptionAr: json["descriptionAr"],
        qrCodePath: json["qrCodePath"],
        rating: json["rating"],
        isRated: json["isRated"],
        qrCode: json["qrCode"],
        statusAr: json["statusAr"],
        process: json["process"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customerId": customerId,
        "ticketTypeId": ticketTypeId,
        "requestedDate": requestedDate.toIso8601String(),
        "selectedDate": selectedDate.toIso8601String(),
        "selectedDateTime": selectedDateTime,
        "timeFrom": timeFrom.toIso8601String(),
        "timeTo": timeTo.toIso8601String(),
        "teamNo": teamNo,
        "status": status,
        "location": location,
        "longitude": longitude,
        "latitude": latitude,
        "gender": gender,
        "isWithMaterial": isWithMaterial,
        "priority": priority,
        "createdBy": createdBy,
        "customerPackageId": customerPackageId,
        "totalPrice": totalPrice,
        "promoCode": promoCode,
        "serviceprovide": serviceprovide,
        "serviceprovideImage": serviceprovideImage,
        "description": description,
        "descriptionAr": descriptionAr,
        "qrCodePath": qrCodePath,
        "rating": rating,
        "isRated": isRated,
        "qrCode": qrCode,
        "statusAr": statusAr,
        "process": process,
      };
}
