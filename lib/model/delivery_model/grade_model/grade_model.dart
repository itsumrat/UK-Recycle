// To parse this JSON data, do
//
//     final gradeModel = gradeModelFromJson(jsonString);

import 'dart:convert';

GradeModel gradeModelFromJson(String str) => GradeModel.fromJson(json.decode(str));

String gradeModelToJson(GradeModel data) => json.encode(data.toJson());

class GradeModel {
  final bool? success;
  final List<GradeDatum>? data;
  final String? message;

  GradeModel({
    this.success,
    this.data,
    this.message,
  });

  factory GradeModel.fromJson(Map<String, dynamic> json) => GradeModel(
        success: json["success"],
        data: json["data"] == null ? [] : List<GradeDatum>.from(json["data"]!.map((x) => GradeDatum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class GradeDatum {
  final int? id;
  final String? gradeId;
  final String? name;
  final num? weight;
  final String? createdAt;
  final String? updatedAt;

  GradeDatum({
    this.id,
    this.gradeId,
    this.name,
    this.weight,
    this.createdAt,
    this.updatedAt,
  });

  factory GradeDatum.fromJson(Map<String, dynamic> json) => GradeDatum(
        id: json["id"],
        gradeId: json["grade_id"],
        name: json["name"],
        weight: json["weight"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "grade_id": gradeId,
        "name": name,
        "weight": weight,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
