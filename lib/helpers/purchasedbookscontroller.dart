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
import '../data/purchaselist.dart';
import '../data/subscriptionplanslist.dart';
import '../data/userrepo.dart';
import 'constants.dart';

class PurchasedBookController extends GetxController {
  bool isLoading = true;
  final userRepo = Get.find<UserRepoController>();
  List<PurchaseList> purchasedbooksList = [];
  PurchaseList? selectedPurchase;


 @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPurchases();
  }

  Future<List<PurchaseList>> getPurchases() async {
    isLoading = true;
    var response = await http.get(
      Uri.parse("${mainUrl}myPurchases"),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userRepo.getUserToken()}',
      },
    );
    purchasedbooksList = purchaseListFromJson(response.body);
    isLoading = false;
    update();
    return purchasedbooksList;
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
