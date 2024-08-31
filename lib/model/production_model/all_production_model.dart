// To parse this JSON data, do
//
//     final allProductionModel = allProductionModelFromJson(jsonString);

import 'dart:convert';

import 'package:crm/utility/app_const.dart';

AllProductionModel allProductionModelFromJson(String str) => AllProductionModel.fromJson(json.decode(str));

String allProductionModelToJson(AllProductionModel data) => json.encode(data.toJson());

class AllProductionModel {
  final bool? success;
  final List<AllProductionDatum>? data;
  final String? message;

  AllProductionModel({
    this.success,
    this.data,
    this.message,
  });

  factory AllProductionModel.fromJson(Map<String, dynamic> json) => AllProductionModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<AllProductionDatum>.from(json["data"]!.map((x) => AllProductionDatum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class AllProductionDatum {
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
  final Tables? tables;

  AllProductionDatum({
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
    this.tables,
  });

  factory AllProductionDatum.fromJson(Map<String, dynamic> json) => AllProductionDatum(
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
        tables: json["tables"] == null ? null : Tables.fromJson(json["tables"]),
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
        "tables": tables?.toJson(),
      };
}

extension Helper on AllProductionDatum {
  // "${data.productionId}/${data.createdAt != null ? DateFormat("dd-MM-yyyy").format(data.createdAt!) : "N\\A"}/${data.assignedTo?.name}/${data.tables!.name}"
  String get productionIdString {
    return "$productionId/${createdAt != null ? AppConst.formetData(createdAt) : "N\\A"}/${assignedTo?.name}/${tables!.name}";
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Tables {
  final int? id;
  final String? tableId;
  final String? name;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Tables({
    this.id,
    this.tableId,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Tables.fromJson(Map<String, dynamic> json) => Tables(
        id: json["id"],
        tableId: json["table_id"],
        name: json["name"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "table_id": tableId,
        "name": name,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
