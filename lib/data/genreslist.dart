// To parse this JSON data, do
//
//     final genresList = genresListFromJson(jsonString);

import 'dart:convert';

import 'package:ebookapp/data/booklist.dart';

List<GenresList> genresListFromJson(String str) =>  List<GenresList>.from(
        json.decode(str)!.map((x) => GenresList.fromJson(x)));

String genresListToJson(List<GenresList> data) => json.encode(
     List<dynamic>.from(data.map((x) => x.toJson())));


class GenresList {
  GenresList({
    this.id,
    this.name,
    this.photo,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.isfeatured,
  });

  int? id;
  String? name;
  String? photo;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? isfeatured;
  List<BookList> booklists = [];

  factory GenresList.fromJson(Map<String, dynamic> json) => GenresList(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isfeatured: int.parse(json["isfeatured"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "isfeatured": isfeatured,
      };
}
