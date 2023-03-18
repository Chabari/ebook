import 'dart:convert';

import 'package:ebookapp/data/booklist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/genreslist.dart';
import '../data/userrepo.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

class CategoryDetailsController extends GetxController {
  final userRepo = Get.find<UserRepoController>();
  final searchController = TextEditingController();
  GenresList? genrelist;
  String text = "";
  bool istyping = true;
  List<BookList> filteredbooklists = [];

  void updateissearching(type) {
    istyping = type;
    update();
  }

  void _stopSearching() {
    _clearSearchQuery();
  }

  //clear search box data.
  void _clearSearchQuery() {
    searchController.clear();
    searchController.text = "";
    updateSearchQuery("");
  }


  void updateSearchQuery(String newQuery) {
    filteredbooklists.clear();
    istyping = true;
    if (newQuery.length > 0) {
      Set<BookList> set = Set.from(genrelist!.booklists);
      set.forEach((element) => filterList(element, newQuery));
    } else {
      text = "Search for products here";
      filteredbooklists.addAll(genrelist!.booklists);
      //filteredproductslists = productslists;
    }
    update();
  }

  filterList(BookList product, String searchQuery) {
    if (product.title.toLowerCase().contains(searchQuery) ||
        product.cost.toLowerCase().contains(searchQuery)) {
      filteredbooklists.add(product);
    } else {
      text = "No products found";
    }
    update();
  }

  Future getGenreDetails(id) async {
    var response = await http.get(
      Uri.parse("${mainUrl}get-genre-details?id=$id"),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userRepo.getUserToken()}',
      },
    );
    print(response.body);
    Map<String, dynamic> json1 = json.decode(response.body);
    genrelist = GenresList.fromJson(json1['genre']);
    genrelist!.booklists =
        List<BookList>.from(json1['books'].map((x) => BookList.fromJson(x)));
    filteredbooklists.addAll(genrelist!.booklists);

    update();

    return genrelist;
  }
}
