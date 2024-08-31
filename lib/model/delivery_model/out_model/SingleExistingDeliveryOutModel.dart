// To parse this JSON data, do
//
//     final singleExistingDeliveryOutModel = singleExistingDeliveryOutModelFromJson(jsonString);

import 'dart:convert';

SingleExistingDeliveryOutModel singleExistingDeliveryOutModelFromJson(String str) =>
    SingleExistingDeliveryOutModel.fromJson(json.decode(str));

String singleExistingDeliveryOutModelToJson(SingleExistingDeliveryOutModel data) => json.encode(data.toJson());

class SingleExistingDeliveryOutModel {
  final bool? success;
  final Data? data;
  final String? message;

  SingleExistingDeliveryOutModel({
    this.success,
    this.data,
    this.message,
  });

  factory SingleExistingDeliveryOutModel.fromJson(Map<String, dynamic> json) => SingleExistingDeliveryOutModel(
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
  final num? weight;

  Data({
    this.delivery,
    this.weight,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        delivery: json["delivery"] == null ? null : Delivery.fromJson(json["delivery"]),
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "delivery": delivery?.toJson(),
        "weight": weight,
      };
}

class Delivery {
  final int? id;
  final DateTime? date;
  final String? deliveryOutId;
  final int? categoryId;
  final int? deliveryType;
  final int? customerId;
  final int? measurementType;
  final int? addedBy;
  final dynamic caseId;
  final dynamic pallet;
  final dynamic deliveryCase;
  final dynamic piece;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic user;
  final Categories? categories;
  final Customer? customer;
  final Measurement? measurement;

  Delivery({
    this.id,
    this.date,
    this.deliveryOutId,
    this.categoryId,
    this.deliveryType,
    this.customerId,
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
    this.customer,
    this.measurement,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
        id: json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        deliveryOutId: json["delivery_out_id"],
        categoryId: json["category_id"],
        deliveryType: json["delivery_type"],
        customerId: json["customer_id"],
        measurementType: json["Measurement_type"],
        addedBy: json["added_by"],
        caseId: json["case_id"],
        pallet: json["pallet"],
        deliveryCase: json["case"],
        piece: json["piece"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"],
        categories: json["categories"] == null ? null : Categories.fromJson(json["categories"]),
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
        measurement: json["measurement"] == null ? null : Measurement.fromJson(json["measurement"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date?.toIso8601String(),
        "delivery_out_id": deliveryOutId,
        "category_id": categoryId,
        "delivery_type": deliveryType,
        "customer_id": customerId,
        "Measurement_type": measurementType,
        "added_by": addedBy,
        "case_id": caseId,
        "pallet": pallet,
        "case": deliveryCase,
        "piece": piece,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user,
        "categories": categories?.toJson(),
        "customer": customer?.toJson(),
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

class Customer {
  final int? id;
  final String? customerId;
  final String? name;
  final String? email;
  final String? address;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Customer({
    this.id,
    this.customerId,
    this.name,
    this.email,
    this.address,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        customerId: json["customer_id"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "name": name,
        "email": email,
        "address": address,
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
