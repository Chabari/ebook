import 'dart:convert';

import 'package:ars_progress_dialog/dialog.dart';
import 'package:ebookapp/data/genreslist.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

import 'package:http/http.dart' as http;
import '../data/booklist.dart';
import '../data/mysubscriptionslist.dart';
import '../data/subscriptionplanslist.dart';
import '../data/userrepo.dart';
import 'constants.dart';

class UserSubscriptionsController extends GetxController {
  bool isLoading = true;
  final userRepo = Get.find<UserRepoController>();
  List<MySubscriptionsList> usersubscriptions = [];
  MySubscriptionsList? selectedplan;


 @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getplans();
  }

  Future<List<MySubscriptionsList>> getplans() async {
    isLoading = true;
    var response = await http.get(
      Uri.parse("${mainUrl}getmysubscription"),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userRepo.getUserToken()}',
      },
    );
    print(response.body);
    usersubscriptions = mySubscriptionsListFromJson(response.body);
    isLoading = false;
    update();
    return usersubscriptions;
  }


  void showToast(message, color) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

}
