// To parse this JSON data, do
//
//     final transactionByProductionModel = transactionByProductionModelFromJson(jsonString);

import 'dart:convert';

TransactionByProductionModel transactionByProductionModelFromJson(String str) =>
    TransactionByProductionModel.fromJson(json.decode(str));

String transactionByProductionModelToJson(TransactionByProductionModel data) => json.encode(data.toJson());

class TransactionByProductionModel {
  final bool? success;
  final List<TransactionDatum>? data;
  final String? message;

  TransactionByProductionModel({
    this.success,
    this.data,
    this.message,
  });

  factory TransactionByProductionModel.fromJson(Map<String, dynamic> json) => TransactionByProductionModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<TransactionDatum>.from(json["data"]!.map((x) => TransactionDatum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class TransactionDatum {
  final int? id;
  final int? productionId;
  final num? weight;
  final int? grade;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Grades? grades;

  TransactionDatum({
    this.id,
    this.productionId,
    this.weight,
    this.grade,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.grades,
  });

  factory TransactionDatum.fromJson(Map<String, dynamic> json) => TransactionDatum(
        id: json["id"],
        productionId: json["production_id"],
        weight: json["weight"],
        grade: json["grade"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        grades: json["grades"] == null ? null : Grades.fromJson(json["grades"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "production_id": productionId,
        "weight": weight,
        "grade": grade,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "grades": grades?.toJson(),
      };
}

class Grades {
  final int? id;
  final String? gradeId;
  final String? name;
  final dynamic weight;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Grades({
    this.id,
    this.gradeId,
    this.name,
    this.weight,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Grades.fromJson(Map<String, dynamic> json) => Grades(
        id: json["id"],
        gradeId: json["grade_id"],
        name: json["name"],
        weight: json["weight"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "grade_id": gradeId,
        "name": name,
        "weight": weight,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
