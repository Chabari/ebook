import 'dart:convert';

import 'package:ars_progress_dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/constants.dart';

class ResetPassController extends GetxController {
  var currentIndex = 0;
  bool isObscure = true;
  late BuildContext? context = Get.context;
  final emailController = TextEditingController();
  final passwordCOntroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.85);

  late ArsProgressDialog progressDialog = ArsProgressDialog(context,
      blur: 2,
      backgroundColor: const Color(0x33000000),
      animationDuration: const Duration(milliseconds: 500));

  void setObscure(obs) {
    isObscure = obs;
    update();
  }

  void validateSubmit() async {
    var formstate = formKey.currentState;
    if (formstate!.validate()) {
      progressDialog.show();
      var data = {
        'password': passwordCOntroller.text,
        'email': emailController.text
      };
      var body = json.encode(data);
      print(body);
      var response = await http.post(Uri.parse("${mainUrl}login"),
          headers: {
            "Content-Type": "application/json",
            'Accept': 'application/json',
          },
          body: body);
      final mpref = await SharedPreferences.getInstance();
      Map<String, dynamic> json1 = json.decode(response.body);
      if (response.statusCode == 200) {
        progressDialog.dismiss();
        if (json1['success'] == "1") {
          Map<String, dynamic> user = json1['user'];
          mpref.setString("token", json1['token']);
          mpref.setString("email", user['email']);
          mpref.setString("name", user['name']);
          mpref.setString("user_id", user['id'].toString());
          mpref.setString("phone", user['phone']);
          mpref.setString("support_email", json1['support_email']);
          mpref.setString("call_phone", json1['call_phone']);
          mpref.setBool('isFirst', false);
          showToast(json1['message'], Colors.green);
          Get.offNamed('/mainpanel');
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
