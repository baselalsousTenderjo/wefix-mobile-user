// To parse this JSON data, do
//
//     final contractDetails = contractDetailsFromJson(jsonString);

import 'dart:convert';

ContractDetails contractDetailsFromJson(String str) =>
    ContractDetails.fromJson(json.decode(str));

String contractDetailsToJson(ContractDetails data) =>
    json.encode(data.toJson());

class ContractDetails {
  CustomerPackages customerPackages;

  ContractDetails({
    required this.customerPackages,
  });

  factory ContractDetails.fromJson(Map<String, dynamic> json) =>
      ContractDetails(
        customerPackages: CustomerPackages.fromJson(json["customerPackages"]),
      );

  Map<String, dynamic> toJson() => {
        "customerPackages": customerPackages.toJson(),
      };
}

class CustomerPackages {
  int id;
  String name;
  String status;
  DateTime startDate;
  DateTime endDate;
  dynamic price;
  int recurringVist;
  int totalRecurringVist;
  int onDemandVisit;
  int totalOnDemandVisit;
  int emeregencyVisit;
  int totalEmeregencyVisit;
  int totalNumberOnFemalUse;
  int numberOnFemalUse;
  int consultation;
  String? interiorDesign;
  dynamic discount;

  CustomerPackages({
    required this.id,
    this.interiorDesign,
    this.discount,
    required this.consultation,
    required this.name,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.recurringVist,
    required this.totalRecurringVist,
    required this.onDemandVisit,
    required this.totalOnDemandVisit,
    required this.emeregencyVisit,
    required this.totalEmeregencyVisit,
    required this.totalNumberOnFemalUse,
    required this.numberOnFemalUse,
  });

  factory CustomerPackages.fromJson(Map<String, dynamic> json) =>
      CustomerPackages(
        id: json["id"],
        discount: json["discount"],
        name: json["name"],
        interiorDesign: json["interiorDesign"],
        consultation: json["consultation"],
        status: json["status"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        price: json["price"],
        recurringVist: json["recurringVist"],
        totalRecurringVist: json["totalRecurringVist"],
        onDemandVisit: json["onDemandVisit"],
        totalOnDemandVisit: json["totalOnDemandVisit"],
        emeregencyVisit: json["emeregencyVisit"],
        totalEmeregencyVisit: json["totalEmeregencyVisit"],
        totalNumberOnFemalUse: json["totalNumberOnFemalUse"],
        numberOnFemalUse: json["numberOnFemalUse"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "price": price,
        "recurringVist": recurringVist,
        "totalRecurringVist": totalRecurringVist,
        "onDemandVisit": onDemandVisit,
        "totalOnDemandVisit": totalOnDemandVisit,
        "emeregencyVisit": emeregencyVisit,
        "totalEmeregencyVisit": totalEmeregencyVisit,
        "totalNumberOnFemalUse": totalNumberOnFemalUse,
        "numberOnFemalUse": numberOnFemalUse,
      };
}
