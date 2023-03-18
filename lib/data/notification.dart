// To parse this JSON data, do
//
//     final subscriptionPlansList = subscriptionPlansListFromJson(jsonString);

import 'dart:convert';

class NotificationList {
    NotificationList({
        required this.id,
        required this.is_read,
        required this.narration,
        required this.user_id,
        required this.message,
        required this.reference,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String message;
    String user_id;
    String narration;
    int is_read;
    String reference;
    DateTime createdAt;
    DateTime updatedAt;


    factory NotificationList.fromJson(Map<String, dynamic> json) => NotificationList(
        id: json["id"],
        message: json["message"],
        user_id: json["user_id"],
        narration: json["narration"],
        is_read: json["is_read"],
        reference: json["reference"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

}
