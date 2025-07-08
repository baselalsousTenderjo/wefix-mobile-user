// To parse this JSON data, do
//
//     final packagesModel = packagesModelFromJson(jsonString);

import 'dart:convert';

PackagesModel packagesModelFromJson(String str) =>
    PackagesModel.fromJson(json.decode(str));

String packagesModelToJson(PackagesModel data) => json.encode(data.toJson());

class PackagesModel {
  List<PackagesModelPackage> packages;

  PackagesModel({
    required this.packages,
  });

  factory PackagesModel.fromJson(Map<String, dynamic> json) => PackagesModel(
        packages: List<PackagesModelPackage>.from(
            json["packages"].map((x) => PackagesModelPackage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "packages": List<dynamic>.from(packages.map((x) => x.toJson())),
      };
}

class PackagesModelPackage {
  int id;
  String title;
  String titleAr;
  int sortOder;
  List<PackagePackage> package;

  PackagesModelPackage({
    required this.id,
    required this.title,
    required this.titleAr,
    required this.sortOder,
    required this.package,
  });

  factory PackagesModelPackage.fromJson(Map<String, dynamic> json) =>
      PackagesModelPackage(
        id: json["id"],
        title: json["title"],
        titleAr: json["titleAr"],
        sortOder: json["sortOder"],
        package: List<PackagePackage>.from(
            json["package"].map((x) => PackagePackage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "titleAr": titleAr,
        "sortOder": sortOder,
        "package": List<dynamic>.from(package.map((x) => x.toJson())),
      };
}

class PackagePackage {
  int id;
  String? title;
  String? titleAr;
  int? price;
  int? duration;
  int? consultation;
  String? interiorDesign;
  int? discount;
  int? numberOfUrgentVisits;
  int? numberOfRegularVisit;
  int? numberOnDemandVisit;
  int? numberOfFemalUse;
  int? totalvisit;
  List<Feature> features;

  PackagePackage({
    required this.id,
    required this.title,
    required this.titleAr,
    required this.price,
    required this.duration,
    required this.consultation,
    required this.interiorDesign,
    required this.discount,
    required this.numberOfUrgentVisits,
    required this.numberOfRegularVisit,
    required this.numberOnDemandVisit,
    required this.numberOfFemalUse,
    required this.totalvisit,
    required this.features,
  });

  factory PackagePackage.fromJson(Map<String, dynamic> json) => PackagePackage(
        id: json["id"],
        title: json["title"],
        titleAr: json["titleAr"],
        price: json["price"],
        duration: json["duration"],
        consultation: json["consultation"],
        interiorDesign: json["interiorDesign"],
        discount: json["discount"],
        numberOfUrgentVisits: json["numberOfUrgentVisits"],
        numberOfRegularVisit: json["numberOfRegularVisit"],
        numberOnDemandVisit: json["numberOnDemandVisit"],
        numberOfFemalUse: json["numberOfFemalUse"],
        totalvisit: json["totalvisit"],
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "titleAr": titleAr,
        "price": price,
        "duration": duration,
        "consultation": consultation,
        "interiorDesign": interiorDesign,
        "discount": discount,
        "numberOfUrgentVisits": numberOfUrgentVisits,
        "numberOfRegularVisit": numberOfRegularVisit,
        "numberOnDemandVisit": numberOnDemandVisit,
        "numberOfFemalUse": numberOfFemalUse,
        "totalvisit": totalvisit,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
      };
}

class Feature {
  int id;
  String feature;
  String featureAr;
  bool status;

  Feature({
    required this.id,
    required this.feature,
    required this.featureAr,
    required this.status,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        feature: json["feature"],
        featureAr: json["featureAR"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "feature": feature,
        "featureAR": featureAr,
        "status": status,
      };
}
