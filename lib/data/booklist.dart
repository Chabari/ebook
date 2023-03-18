// To parse this JSON data, do
//
//     final bookList = bookListFromJson(jsonString);

import 'dart:convert';

List<BookList> bookListFromJson(String str) =>
    List<BookList>.from(json.decode(str).map((x) => BookList.fromJson(x)));

String bookListToJson(List<BookList?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class BookList {
  BookList({
    required this.id,
    required this.title,
    required this.photo,
    required this.introduction,
    required this.genreId,
    required this.ageGate,
    required this.status,
    required this.authorId,
    required this.uploadedBy,
    required this.authersNote,
    required this.genre_name,
    required this.isActive,
    required this.author_name,
    this.createdAt,
    this.updatedAt,
    this.datePublished,
    required this.cost,
    required this.bookpath,
    required this.filename,
    required this.freeChapters,
    required this.chapters,
    this.booktags,
  });

  int id;
  String title;
  String photo;
  String introduction;
  String genreId;
  String ageGate;
  String status;
  String author_name;
  String genre_name;
  String authorId;
  String uploadedBy;
  String authersNote;
  int isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? datePublished;
  String cost;
  String bookpath;
  String filename;
  String chapters;
  List<Booktag?>? booktags;
  List<FreeChapter> freeChapters;

  factory BookList.fromJson(Map<String, dynamic> json) => BookList(
        id: json["id"],
        title: json["title"] ?? "",
        photo: json["photo"] ?? "",
        genre_name: json['genre_name'],
        introduction: json["introduction"] ?? "",
        genreId: json["genre_id"],
        ageGate: json["age_gate"],
        author_name: json['author_name'],
        status: json["status"],
        authorId: json["author_id"],
        uploadedBy: json["uploaded_by"],
        authersNote: json["authers_note"] ?? "",
        isActive: int.parse(json["isActive"].toString()),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        datePublished: DateTime.parse(json["date_published"]),
        freeChapters: json["free_chapters"].length > 0 ? List<FreeChapter>.from(json["free_chapters"].map((x) => FreeChapter.fromJson(x))) : [],
        cost: json["cost"],
        bookpath: json["bookpath"] ?? "",
        filename: json["filename"] ?? "",
        chapters: json["chapters"] ?? "",
        booktags: json["booktags"] == null
            ? []
            : List<Booktag?>.from(
                json["booktags"]!.map((x) => Booktag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "photo": photo,
        "introduction": introduction,
        "genre_id": genreId,
        "age_gate": ageGate,
        "status": status,
        "author_id": authorId,
        "uploaded_by": uploadedBy,
        "authers_note": authersNote,
        "isActive": isActive,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "date_published":
            "${datePublished!.year.toString().padLeft(4, '0')}-${datePublished!.month.toString().padLeft(2, '0')}-${datePublished!.day.toString().padLeft(2, '0')}",
        "cost": cost,
        "bookpath": bookpath,
        "filename": filename,
        "chapters": chapters,
      };
}

class Booktag {
  Booktag({
    this.id,
    this.bookId,
    this.tagId,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? bookId;
  String? tagId;
  DateTime? createdAt;
  String? name;
  DateTime? updatedAt;

  factory Booktag.fromJson(Map<String, dynamic> json) => Booktag(
        id: json["id"],
        bookId: json["book_id"],
        name: json["tag_name"],
        tagId: json["tag_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "book_id": bookId,
        "tag_id": tagId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}


class FreeChapter {
    FreeChapter({
        required this.id,
        required this.chapter,
        required this.content,
        required this.bookId,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String chapter;
    String content;
    String bookId;
    DateTime createdAt;
    DateTime updatedAt;

    factory FreeChapter.fromJson(Map<String, dynamic> json) => FreeChapter(
        id: json["id"],
        chapter: json["chapter"],
        content: json["content"],
        bookId: json["book_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "chapter": chapter,
        "content": content,
        "book_id": bookId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}