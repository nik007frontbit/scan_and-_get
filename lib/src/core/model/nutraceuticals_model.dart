// To parse this JSON data, do
//
//     final nutraceuticalModel = nutraceuticalModelFromJson(jsonString);

import 'dart:convert';

NutraceuticalModel nutraceuticalModelFromJson(String str) => NutraceuticalModel.fromJson(json.decode(str));

String nutraceuticalModelToJson(NutraceuticalModel data) => json.encode(data.toJson());

class NutraceuticalModel {
  final int statusCode;
  final String statusMessage;
  final List<List<List<String>>> data;

  NutraceuticalModel({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  NutraceuticalModel copyWith({
    int? statusCode,
    String? statusMessage,
    List<List<List<String>>>? data,
  }) =>
      NutraceuticalModel(
        statusCode: statusCode ?? this.statusCode,
        statusMessage: statusMessage ?? this.statusMessage,
        data: data ?? this.data,
      );

  factory NutraceuticalModel.fromJson(Map<String, dynamic> json) => NutraceuticalModel(
    statusCode: json["status_code"],
    statusMessage: json["status_message"],
    data: List<List<List<String>>>.from(json["data"].map((x) => List<List<String>>.from(x.map((x) => List<String>.from(x.map((x) => x)))))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status_message": statusMessage,
    "data": List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
  };
}
