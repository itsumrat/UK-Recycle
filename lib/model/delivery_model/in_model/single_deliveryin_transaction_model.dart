// To parse this JSON data, do
//
//     final transcaByDeliveryInIdModel = transcaByDeliveryInIdModelFromJson(jsonString);

import 'dart:convert';

import 'package:crm/model/cage_model/cage_model.dart';
import 'package:crm/model/delivery_model/in_model/deliveryin_model.dart';

TranscaByDeliveryInIdModel transcaByDeliveryInIdModelFromJson(String str) =>
    TranscaByDeliveryInIdModel.fromJson(json.decode(str));

String transcaByDeliveryInIdModelToJson(TranscaByDeliveryInIdModel data) => json.encode(data.toJson());

class TranscaByDeliveryInIdModel {
  final bool? success;
  final Data? data;
  final String? message;

  TranscaByDeliveryInIdModel({
    this.success,
    this.data,
    this.message,
  });

  factory TranscaByDeliveryInIdModel.fromJson(Map<String, dynamic> json) => TranscaByDeliveryInIdModel(
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
  final List<Transaction>? transaction;
  final double? weight;

  Data({
    this.transaction,
    this.weight,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transaction: json["transaction"] == null
            ? []
            : List<Transaction>.from(json["transaction"]!.map((x) => Transaction.fromJson(x))),
        weight: double.tryParse(json["weight"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "transaction": transaction == null ? [] : List<dynamic>.from(transaction!.map((x) => x.toJson())),
        "weight": weight,
      };
}

class Transaction {
  final int? id;
  final String? deliveryId;
  final DateTime? date;
  final int? addedBy;
  final int? measurement;
  final dynamic caseId;
  final double? weight;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Measurements? measurements;
  final User? user;
  final Categories? category;

  final double? productWeight;

  final CageDatum? cage;

  Transaction({
    this.id,
    this.deliveryId,
    this.date,
    this.addedBy,
    this.measurement,
    this.caseId,
    this.weight,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.measurements,
    this.user,
    this.productWeight,
    this.cage,
    this.category,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        deliveryId: json["delivery_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        addedBy: json["added_by"],
        measurement: json["measurement"],
        caseId: json["case_id"],
        weight: double.tryParse(json["weight"].toString()),
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        measurements: json["measurements"] == null ? null : Measurements.fromJson(json["measurements"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        productWeight: double.tryParse(json["product_weight"].toString()),
        cage: json["cage"] == null ? null : CageDatum.fromJson(json["cage"]),
        category: json["category"] == null ? null : Categories.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "delivery_id": deliveryId,
        "date": date?.toIso8601String(),
        "added_by": addedBy,
        "measurement": measurement,
        "case_id": caseId,
        "weight": weight,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "measurements": measurements?.toJson(),
        "user": user?.toJson(),
        "product_weight": productWeight,
        "cage": cage?.toJson(),
        "category": category?.toJson(),
      };
}

class Measurements {
  final int? id;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Measurements({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Measurements.fromJson(Map<String, dynamic> json) => Measurements(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final dynamic emailVerifiedAt;
  final String? uid;
  final dynamic address;
  final String? userType;
  final dynamic passkey;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.uid,
    this.address,
    this.userType,
    this.passkey,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        uid: json["uid"],
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
        "user_id": uid,
        "address": address,
        "user_type": userType,
        "passkey": passkey,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
