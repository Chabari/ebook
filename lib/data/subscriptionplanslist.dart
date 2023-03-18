// To parse this JSON data, do
//
//     final subscriptionPlansList = subscriptionPlansListFromJson(jsonString);

import 'dart:convert';

List<SubscriptionPlansList> subscriptionPlansListFromJson(String str) => List<SubscriptionPlansList>.from(json.decode(str).map((x) => SubscriptionPlansList.fromJson(x)));

String subscriptionPlansListToJson(List<SubscriptionPlansList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubscriptionPlansList {
    SubscriptionPlansList({
        required this.id,
        required this.title,
        required this.period,
        required this.periodCount,
        required this.amount,
        required this.maxUsers,
        required this.readOnly,
        required this.readAndDownload,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String title;
    String period;
    String periodCount;
    String amount;
    String maxUsers;
    int readOnly;
    int readAndDownload;
    DateTime createdAt;
    DateTime updatedAt;

    factory SubscriptionPlansList.fromJson(Map<String, dynamic> json) => SubscriptionPlansList(
        id: json["id"],
        title: json["title"],
        period: json["period"],
        periodCount: json["period_count"],
        amount: json["amount"],
        maxUsers: json["max_users"],
        readOnly: json["read_only"],
        readAndDownload: json["read_and_download"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "period": period,
        "period_count": periodCount,
        "amount": amount,
        "max_users": maxUsers,
        "read_only": readOnly,
        "read_and_download": readAndDownload,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
