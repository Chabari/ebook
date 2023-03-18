import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPanelController extends GetxController {
  var currentIndex = 0;
  PageController pageController = PageController();
  PageController pageController2 = PageController();
  void setScreen(index) {
    currentIndex = index;
    update();
  }

  void animateTo(index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

}
