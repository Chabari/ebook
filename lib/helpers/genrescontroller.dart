import 'package:ebookapp/data/genreslist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

import 'package:http/http.dart' as http;
import '../data/userrepo.dart';
import 'constants.dart';

class GenresController extends GetxController {
  var currentIndex = 1;

  bool isLoading = false;
  PageController pageController = PageController();
  final userRepo = Get.find<UserRepoController>();
  List<GenresList> genreslists = [];
  void setScreen(index) {
    currentIndex = index;
    update();
  }

  Future<List<GenresList>> getfeatured() async {
    isLoading = true;
    update();
    var response = await http.get(
      Uri.parse("${mainUrl}get-genres"),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userRepo.getUserToken()}',
      },
    );
    print(response.body);
    genreslists = genresListFromJson(response.body);
    isLoading = false;
    update();
    return genreslists;
  }

  void animateTo(index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}
