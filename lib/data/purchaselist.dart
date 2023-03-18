// To parse this JSON data, do
//
//     final purchaseList = purchaseListFromJson(jsonString);

import 'dart:convert';

List<PurchaseList> purchaseListFromJson(String str) => List<PurchaseList>.from(json.decode(str).map((x) => PurchaseList.fromJson(x)));

String purchaseListToJson(List<PurchaseList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PurchaseList {
    PurchaseList({
        required this.id,
        required this.bookId,
        required this.amount,
        required this.status,
        required this.userId,
        required this.referenceId,
        required this.paymentMethod,
        required this.createdAt,
        required this.updatedAt,
        required this.book,
    });

    int id;
    String bookId;
    String amount;
    String status;
    String userId;
    String referenceId;
    String paymentMethod;
    DateTime createdAt;
    DateTime updatedAt;
    Book book;

    factory PurchaseList.fromJson(Map<String, dynamic> json) => PurchaseList(
        id: json["id"],
        bookId: json["book_id"],
        amount: json["amount"],
        status: json["status"],
        userId: json["user_id"],
        referenceId: json["reference_id"],
        paymentMethod: json["payment_method"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        book: Book.fromJson(json["book"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "book_id": bookId,
        "amount": amount,
        "status": status,
        "user_id": userId,
        "reference_id": referenceId,
        "payment_method": paymentMethod,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "book": book.toJson(),
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
        required this.isSuggested,
        required this.isPopular,
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
    int isSuggested;
    int isPopular;
    String authorName;
    String genreName;

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        title: json["title"] ?? "",
        photo: json["photo"] ?? "",
        introduction: json["introduction"] ?? "",
        genreId: json["genre_id"] ?? "",
        filename: json["filename"] ?? "",
        bookpath: json["bookpath"] ?? "",
        ageGate: json["age_gate"] ?? "",
        chapters: json["chapters"] ?? "",
        cost: json["cost"] ?? "",
        status: json["status"] ?? "",
        datePublished: DateTime.parse(json["date_published"]),
        authorId: json["author_id"] ?? "",
        uploadedBy: json["uploaded_by"] ?? "",
        authersNote: json["authers_note"] ?? "",
        isActive: int.parse(json["isActive"].toString()),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isSuggested: int.parse(json["isSuggested"].toString()),
        isPopular: int.parse(json["isPopular"].toString()),
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
        "isSuggested": isSuggested,
        "isPopular": isPopular,
        "author_name": authorName,
        "genre_name": genreName,
    };
}
