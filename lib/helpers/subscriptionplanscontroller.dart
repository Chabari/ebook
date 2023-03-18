import 'dart:convert';

import 'package:ars_progress_dialog/dialog.dart';
import 'package:ebookapp/data/genreslist.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';

import 'package:http/http.dart' as http;
import '../data/booklist.dart';
import '../data/subscriptionplanslist.dart';
import '../data/userrepo.dart';
import 'constants.dart';

class SubscriptionPlanController extends GetxController {
  bool isLoading = true;
  final userRepo = Get.find<UserRepoController>();
  List<SubscriptionPlansList> subscriptionlists = [];
  SubscriptionPlansList? selectedplan;


    late ArsProgressDialog progressDialog = ArsProgressDialog(Get.context,
        blur: 2,
        backgroundColor: const Color(0x33000000),
        animationDuration: const Duration(milliseconds: 500));

  void setPlan(index) {
    selectedplan = index;
    update();
  }


  Future<List<SubscriptionPlansList>> getplans() async {
    isLoading = true;
    var response = await http.get(
      Uri.parse("${mainUrl}get-subscription-plans"),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userRepo.getUserToken()}',
      },
    );
    print(response.body);
    subscriptionlists = subscriptionPlansListFromJson(response.body);
    isLoading = false;
    update();
    return subscriptionlists;
  }


  void purchase() async {
      progressDialog.show();
      var data = {
        'subscription_id': selectedplan!.id.toString(),
      };
      var body = json.encode(data);
      var response = await http.post(Uri.parse("${mainUrl}subscribe"),
          headers: {
            "Content-Type": "application/json",
            'Accept': 'application/json',
            'Authorization': 'Bearer ${userRepo.getUserToken()}',
          },
          body: body);
      Map<String, dynamic> json1 = json.decode(response.body);
      if (response.statusCode == 200) {
        progressDialog.dismiss();
        if (json1['success'] == "1") {
          showToast(json1['message'], Colors.green);
          Get.offNamed('/ordersuccess', arguments: [json1['code']]);
        } else if (json1['success'] == "2") {
          showToast(json1['message'], Colors.red);
        } else {
          showToast(json1['message'], Colors.red);
        }
      } else {
        progressDialog.dismiss();
        showToast(json1['message'], Colors.red);
      }
    
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
