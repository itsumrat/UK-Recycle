// To parse this JSON data, do
//
//     final singleProductionModel = singleProductionModelFromJson(jsonString);

import 'dart:convert';

import 'package:crm/model/table_molde/table_list_model.dart';
import 'package:crm/utility/app_const.dart';

SingleProductionModel singleProductionModelFromJson(String str) => SingleProductionModel.fromJson(json.decode(str));

String singleProductionModelToJson(SingleProductionModel data) => json.encode(data.toJson());

class SingleProductionModel {
  final bool? success;
  final Data? data;
  final String? message;

  SingleProductionModel({
    this.success,
    this.data,
    this.message,
  });

  factory SingleProductionModel.fromJson(Map<String, dynamic> json) => SingleProductionModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  final Production? production;
  final num? weight;
  final List<Grade>? grades;

  Data({
    this.production,
    this.weight,
    this.grades,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        production: json["production"] == null ? null : Production.fromJson(json["production"]),
        weight: json["weight"],
        grades: json["grades"] == null ? [] : List<Grade>.from(json["grades"]!.map((x) => Grade.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "production": production?.toJson(),
        "weight": weight,
        "grades": grades == null ? [] : List<dynamic>.from(grades!.map((x) => x.toJson())),
      };
}

class Grade {
  final int? id;
  final String? gradeId;
  final String? name;
  final dynamic weight;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Grade({
    this.id,
    this.gradeId,
    this.name,
    this.weight,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Grade.fromJson(Map<String, dynamic> json) => Grade(
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

class Production {
  final int? id;
  final String? productionId;
  final DateTime? productionDate;
  final int? table;
  final AssignedTo? assignedTo;
  final num? weight;
  final int? grade;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic grades;
  TableDatum? tableData;

  Production({
    this.id,
    this.productionId,
    this.productionDate,
    this.table,
    this.assignedTo,
    this.weight,
    this.grade,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.grades,
    this.tableData,
  });

  factory Production.fromJson(Map<String, dynamic> json) => Production(
        id: json["id"],
        productionId: json["production_id"],
        productionDate: json["production_date"] == null ? null : DateTime.parse(json["production_date"]),
        table: json["table"],
        assignedTo: json["assigned_to"] == null ? null : AssignedTo.fromJson(json["assigned_to"]),
        weight: json["weight"],
        grade: json["grade"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        grades: json["grades"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "production_id": productionId,
        "production_date": productionDate?.toIso8601String(),
        "table": table,
        "assigned_to": assignedTo?.toJson(),
        "weight": weight,
        "grade": grade,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "grades": grades,
      };
}

extension Helper on Production {
  // "${data.productionId}/${data.createdAt != null ? DateFormat("dd-MM-yyyy").format(data.createdAt!) : "N\\A"}/${data.assignedTo?.name}/${data.tables!.name}"
  String get productionIdString {
    String pid = productionId!.split('PR').last;
    pid = "PR${pid.padLeft(6, '0')}";
    return "$pid/${createdAt != null ? AppConst.formetData(createdAt) : "N\\A"}/${assignedTo?.name}/${tableData == null ? table : tableData!.name}";
  }
}

class AssignedTo {
  final int? id;
  final String? name;
  final String? email;
  final dynamic emailVerifiedAt;
  final String? userId;
  final String? address;
  final String? userType;
  final dynamic passkey;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AssignedTo({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.userId,
    this.address,
    this.userType,
    this.passkey,
    this.createdAt,
    this.updatedAt,
  });

  factory AssignedTo.fromJson(Map<String, dynamic> json) => AssignedTo(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        userId: json["user_id"],
        address: json["address"],
        userType: json["user_type"],
        passkey: json["passkey"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "user_id": userId,
        "address": address,
        "user_type": userType,
        "passkey": passkey,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
