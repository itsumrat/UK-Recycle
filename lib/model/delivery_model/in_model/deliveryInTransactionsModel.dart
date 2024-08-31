// To parse this JSON data, do
//
//     final allDeliveryInTransaction = allDeliveryInTransactionFromJson(jsonString);

import 'dart:convert';

AllDeliveryInTransaction allDeliveryInTransactionFromJson(String str) =>
    AllDeliveryInTransaction.fromJson(json.decode(str));

String allDeliveryInTransactionToJson(AllDeliveryInTransaction data) => json.encode(data.toJson());

class AllDeliveryInTransaction {
  final bool? success;
  final List<Datum>? data;
  final String? message;

  AllDeliveryInTransaction({
    this.success,
    this.data,
    this.message,
  });

  factory AllDeliveryInTransaction.fromJson(Map<String, dynamic> json) => AllDeliveryInTransaction(
        success: json["success"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  final int? id;
  final String? deliveryId;
  final DateTime? date;
  final int? addedBy;
  final int? measurement;
  final dynamic caseId;
  final num? weight;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Measurements? measurements;
  final User? user;

  Datum({
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
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        deliveryId: json["delivery_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        addedBy: json["added_by"],
        measurement: json["measurement"],
        caseId: json["case_id"],
        weight: json["weight"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        measurements: json["measurements"] == null ? null : Measurements.fromJson(json["measurements"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
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
  final String? userId;
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
    this.userId,
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
