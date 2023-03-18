import 'dart:convert';

import 'package:ebookapp/data/genreslist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

import 'package:http/http.dart' as http;
import '../data/booklist.dart';
import '../data/userrepo.dart';
import 'constants.dart';

class FeaturesController extends GetxController {
  bool isLoading = true;
  PageController pageController = PageController();
  final userRepo = Get.find<UserRepoController>();
  List<GenresList> genreslists = [];
  GenresList? selectedGenre;

  void setGenre(index) {
    selectedGenre = index;
    getGenreDetails(selectedGenre!.id);
    update();
  }

  Future<List<GenresList>> getfeatured() async {
    isLoading = true;
    var response = await http.get(
      Uri.parse("${mainUrl}get-featured"),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userRepo.getUserToken()}',
      },
    );
    print(response.body);
    genreslists = genresListFromJson(response.body);
    isLoading = false;
    if(genreslists.length > 0){
    selectedGenre = genreslists.first;
    getGenreDetails(selectedGenre!.id);

    }
    update();
    return genreslists;
  }

  Future getGenreDetails(id) async {
    isLoading = true;
    var response = await http.get(
      Uri.parse("${mainUrl}get-genre-details?id=$id"),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userRepo.getUserToken()}',
      },
    );
    print(response.body);
    isLoading = false;
    Map<String, dynamic> json1 = json.decode(response.body);
    selectedGenre = GenresList.fromJson(json1['genre']);
    selectedGenre!.booklists =
        List<BookList>.from(json1['books'].map((x) => BookList.fromJson(x)));

    update();

    return selectedGenre;
  }

  void animateTo(index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}
