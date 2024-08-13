import 'dart:convert';

BatchReaderModel BatchReaderModelFromJson(String str) =>
    BatchReaderModel.fromJson(json.decode(str));

String BatchReaderModelToJson(BatchReaderModel data) =>
    json.encode(data.toJson());

class BatchReaderModel {
  final int statusCode;
  final String statusMessage;
  final Map? data;

  BatchReaderModel({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  BatchReaderModel copyWith({
    int? statusCode,
    String? statusMessage,
    Map? data,
  }) =>
      BatchReaderModel(
        statusCode: statusCode ?? this.statusCode,
        statusMessage: statusMessage ?? this.statusMessage,
        data: data ?? this.data,
      );

  factory BatchReaderModel.fromJson(Map<String, dynamic> json) =>
      BatchReaderModel(
        statusCode: json["status_code"],
        statusMessage: json["data"],
        data: json["status_message"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status_message": statusMessage,
        "data": data,
      };
}
