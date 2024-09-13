// To parse this JSON data, do
//
//     final singleDeliveryInModel = singleDeliveryInModelFromJson(jsonString);

import 'dart:convert';

SingleDeliveryInModel singleDeliveryInModelFromJson(String str) => SingleDeliveryInModel.fromJson(json.decode(str));

String singleDeliveryInModelToJson(SingleDeliveryInModel data) => json.encode(data.toJson());

class SingleDeliveryInModel {
  final bool? success;
  final Data? data;
  final String? message;

  SingleDeliveryInModel({
    this.success,
    this.data,
    this.message,
  });

  factory SingleDeliveryInModel.fromJson(Map<String, dynamic> json) => SingleDeliveryInModel(
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
  final Delivery? delivery;
  final double? weight;
  final double? productWeight;

  Data({
    this.delivery,
    this.weight,
    this.productWeight,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        delivery: json["delivery"] == null ? null : Delivery.fromJson(json["delivery"]),
        weight: double.tryParse(json["weight"].toString()),
        productWeight: double.tryParse(json["product_weight"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "delivery": delivery?.toJson(),
        "weight": weight,
        "product_weight": productWeight,
      };
}

class Delivery {
  final int? id;
  final DateTime? date;
  final String? deliveryInId;
  final int? categoryId;
  final int? deliveryType;
  final int? supplierId;
  final int? measurementType;
  final int? addedBy;
  final dynamic caseId;
  final dynamic pallet;
  final dynamic deliveryCase;
  final dynamic piece;
  final double? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;
  final Categories? categories;
  final Supplier? supplier;
  final Measurement? measurement;

  Delivery({
    this.id,
    this.date,
    this.deliveryInId,
    this.categoryId,
    this.deliveryType,
    this.supplierId,
    this.measurementType,
    this.addedBy,
    this.caseId,
    this.pallet,
    this.deliveryCase,
    this.piece,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.categories,
    this.supplier,
    this.measurement,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
        id: json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        deliveryInId: json["delivery_in_id"],
        categoryId: json["category_id"],
        deliveryType: json["delivery_type"],
        supplierId: json["supplier_id"],
        measurementType: json["Measurement_type"],
        addedBy: json["added_by"],
        caseId: json["case_id"],
        pallet: json["pallet"],
        deliveryCase: json["case"],
        piece: json["piece"],
        status: double.tryParse(json["status"].toString()),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        categories: json["categories"] == null ? null : Categories.fromJson(json["categories"]),
        supplier: json["supplier"] == null ? null : Supplier.fromJson(json["supplier"]),
        measurement: json["measurement"] == null ? null : Measurement.fromJson(json["measurement"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date?.toIso8601String(),
        "delivery_in_id": deliveryInId,
        "category_id": categoryId,
        "delivery_type": deliveryType,
        "supplier_id": supplierId,
        "Measurement_type": measurementType,
        "added_by": addedBy,
        "case_id": caseId,
        "pallet": pallet,
        "case": deliveryCase,
        "piece": piece,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "categories": categories?.toJson(),
        "supplier": supplier?.toJson(),
        "measurement": measurement?.toJson(),
      };
}

class Categories {
  final int? id;
  final String? categoryId;
  final String? name;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Categories({
    this.id,
    this.categoryId,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Measurement {
  final int? id;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Measurement({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Measurement.fromJson(Map<String, dynamic> json) => Measurement(
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

class Supplier {
  final int? id;
  final String? supplierId;
  final String? name;
  final String? email;
  final String? address;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Supplier({
    this.id,
    this.supplierId,
    this.name,
    this.email,
    this.address,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
        id: json["id"],
        supplierId: json["supplier_id"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "supplier_id": supplierId,
        "name": name,
        "email": email,
        "address": address,
        "status": status,
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
  final String? address;
  final String? userType;
  final dynamic passkey;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final String? uid;

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
    this.uid,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        userId: json["id"]?.toString(),
        address: json["address"],
        userType: json["user_type"],
        passkey: json["passkey"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        uid: json["uid"],
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
        "uid": uid,
      };
}
