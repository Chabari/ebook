import 'dart:convert';

import 'package:ars_progress_dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../data/userrepo.dart';
import '../helpers/constants.dart';

class UserProfileController extends GetxController {
  late BuildContext? context = Get.context;
  final emailController = TextEditingController();
  final userRepo = Get.find<UserRepoController>();
  final phoneCOntroller = TextEditingController();
  final firstNameCOntroller = TextEditingController();
  final lastNameCOntroller = TextEditingController();
  final idNumberCOntroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late ArsProgressDialog progressDialog = ArsProgressDialog(context,
      blur: 2,
      backgroundColor: const Color(0x33000000),
      animationDuration: const Duration(milliseconds: 500));
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfile();
  }

  void validateSubmit() async {
    var formstate = formKey.currentState;
    if (formstate!.validate()) {
      progressDialog.show();
      var data = {
        'first_name': firstNameCOntroller.text,
        'last_name': lastNameCOntroller.text,
        'phone': phoneCOntroller.text,
        'email': emailController.text,
        'id_number': idNumberCOntroller.text,
      };
      var body = json.encode(data);
      var response = await http.post(Uri.parse("${mainUrl}edit-profile"),
          headers: {
            "Content-Type": "application/json",
            'Accept': 'application/json',
            'Authorization': 'Bearer ${userRepo.getUserToken()}',
          },
          body: body);
      final mpref = await SharedPreferences.getInstance();
      Map<String, dynamic> json1 = json.decode(response.body);
      if (response.statusCode == 200) {
        progressDialog.dismiss();
        if (json1['success'] == "1") {
          Map<String, dynamic> user = json1['user'];
          mpref.setString("email", user['email']);
          mpref.setString("name", user['name']);
          mpref.setString("phone", user['phone']);

          showToast(json1['message'], Colors.green);
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
  }

  void getProfile() async {
    var response = await http.get(
      Uri.parse("${mainUrl}get-profile"),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userRepo.getUserToken()}',
      },
    );
    final mpref = await SharedPreferences.getInstance();
    Map<String, dynamic> json1 = json.decode(response.body);
    if (response.statusCode == 200) {
      emailController.text = json1['email'];
      phoneCOntroller.text = json1['phone'];
      firstNameCOntroller.text = json1['first_name'];
      lastNameCOntroller.text = json1['last_name'];
      idNumberCOntroller.text = json1['id_number'];
      update();
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
