// To parse this JSON data, do
//
//     final mySubscriptionsList = mySubscriptionsListFromJson(jsonString);

import 'dart:convert';

List<MySubscriptionsList> mySubscriptionsListFromJson(String str) => List<MySubscriptionsList>.from(json.decode(str).map((x) => MySubscriptionsList.fromJson(x)));

String mySubscriptionsListToJson(List<MySubscriptionsList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class MySubscriptionsList {
    MySubscriptionsList({
        required this.id,
        required this.userId,
        required this.subscriptionId,
        required this.usersCount,
        required this.usersEnrolled,
        required this.expiryDate,
        required this.status,
        required this.referenceId,
        required this.createdAt,
        required this.updatedAt,
        required this.amount,
        required this.bookId,
        required this.book,
        required this.subscription,
    });

    int id;
    String userId;
    String subscriptionId;
    String usersCount;
    String usersEnrolled;
    DateTime expiryDate;
    String status;
    String referenceId;
    DateTime createdAt;
    DateTime updatedAt;
    String amount;
    String bookId;
    Book book;
    Subscription subscription;

    factory MySubscriptionsList.fromJson(Map<String, dynamic> json) => MySubscriptionsList(
        id: json["id"],
        userId: json["user_id"],
        subscriptionId: json["subscription_id"],
        usersCount: json["users_count"],
        usersEnrolled: json["users_enrolled"],
        expiryDate: DateTime.parse(json["expiry_date"]),
        status: json["status"],
        referenceId: json["reference_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        amount: json["amount"],
        bookId: json["book_id"],
        book: Book.fromJson(json["book"]),
        subscription: Subscription.fromJson(json["subscription"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "subscription_id": subscriptionId,
        "users_count": usersCount,
        "users_enrolled": usersEnrolled,
        "expiry_date": expiryDate.toIso8601String(),
        "status": status,
        "reference_id": referenceId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "amount": amount,
        "book_id": bookId,
        "book": book.toJson(),
        "subscription": subscription.toJson(),
    };
}

class Book {
    Book({
        required this.id,
        required this.title,
        required this.photo,
        required this.introduction,
        required this.genreId,
        required this.filename,
        required this.bookpath,
        required this.ageGate,
        required this.chapters,
        required this.cost,
        required this.status,
        required this.datePublished,
        required this.authorId,
        required this.uploadedBy,
        required this.authersNote,
        required this.isActive,
        required this.createdAt,
        required this.updatedAt,
        required this.authorName,
        required this.genreName,
    });

    int id;
    String title;
    String photo;
    String introduction;
    String genreId;
    String filename;
    String bookpath;
    String ageGate;
    String chapters;
    String cost;
    String status;
    DateTime datePublished;
    String authorId;
    String uploadedBy;
    String authersNote;
    int isActive;
    DateTime createdAt;
    DateTime updatedAt;
    String authorName;
    String genreName;

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        title: json["title"],
        photo: json["photo"] ?? "",
        introduction: json["introduction"] ?? "",
        genreId: json["genre_id"],
        filename: json["filename"] ?? "",
        bookpath: json["bookpath"] ?? "",
        ageGate: json["age_gate"] ?? "",
        chapters: json["chapters"] ?? "",
        cost: json["cost"] ?? "",
        status: json["status"],
        datePublished: DateTime.parse(json["date_published"]),
        authorId: json["author_id"],
        uploadedBy: json["uploaded_by"],
        authersNote: json["authers_note"],
        isActive: int.parse(json["isActive"].toString()),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        authorName: json["author_name"],
        genreName: json["genre_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "photo": photo,
        "introduction": introduction,
        "genre_id": genreId,
        "filename": filename,
        "bookpath": bookpath,
        "age_gate": ageGate,
        "chapters": chapters,
        "cost": cost,
        "status": status,
        "date_published": "${datePublished.year.toString().padLeft(4, '0')}-${datePublished.month.toString().padLeft(2, '0')}-${datePublished.day.toString().padLeft(2, '0')}",
        "author_id": authorId,
        "uploaded_by": uploadedBy,
        "authers_note": authersNote,
        "isActive": isActive,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "author_name": authorName,
        "genre_name": genreName,
    };
}

class Subscription {
    Subscription({
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

    factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["id"],
        title: json["title"],
        period: json["period"],
        periodCount: json["period_count"] ?? "",
        amount: json["amount"] ?? "",
        maxUsers: json["max_users"] ?? "",
        readOnly: int.parse(json["read_only"].toString()),
        readAndDownload: int.parse(json["read_and_download"].toString()),
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
