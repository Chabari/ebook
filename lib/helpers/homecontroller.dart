import 'dart:convert';

import 'package:ars_progress_dialog/dialog.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../data/booklist.dart';
import '../data/userrepo.dart';
import 'constants.dart';

class HomeController extends GetxController {
  var currentIndex = 0;
  PageController pageController = PageController();
  final CarouselController controllerCorosel = CarouselController();
  late ArsProgressDialog progressDialog = ArsProgressDialog(Get.context,
      blur: 2,
      backgroundColor: const Color(0x33000000),
      animationDuration: const Duration(milliseconds: 500));
  int current = 0;
  List<BookList> booklists = [];
  List<BookList> suggestedbooklists = [];
  bool isLoadingPopular = false;
  BookList? selectedBookList;
  final userRepo = Get.find<UserRepoController>();
  bool isLoadingSuggested = false;

  void setScreen(index) {
    currentIndex = index;
    update();
  }

  void updateState(index) {
    current = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    
  }
  

  // @override
  // void onClose() {
  //   isSuscribed = false;
  //   isPurchased = false;
  //   super.onClose();
  // }


  void animateTo(index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  Future getRecentSubscription() async {
    isLoadingPopular = true;
    var response = await http.get(
      Uri.parse("${mainUrl}get-recent-subscription"),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userRepo.getUserToken()}',
      },
    );
    Map<String, dynamic> json1 = json.decode(response.body);
    if (json1 != null) {}

    update();
    return booklists;
  }

  Future<List<BookList>> getPopularBooks() async {
    isLoadingPopular = true;
    var response = await http.get(
      Uri.parse("${mainUrl}get-popular-books"),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userRepo.getUserToken()}',
      },
    );
    booklists = bookListFromJson(response.body);
    isLoadingPopular = false;

    update();
    return booklists;
  }

  Future<List<BookList>> getSuggested() async {
    isLoadingSuggested = true;
    var response = await http.get(
      Uri.parse("${mainUrl}get-suggested-books"),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userRepo.getUserToken()}',
      },
    );
    suggestedbooklists = bookListFromJson(response.body);
    isLoadingSuggested = false;

    update();
    return booklists;
  }

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Row(
                            children: [
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0)
                                      .copyWith(left: 15, right: 12),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Book',
                                        style: subtitle3,
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();
}
