import 'dart:convert';

import 'package:ebookapp/views/login.dart';
import 'package:ebookapp/views/mainpanel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'helpers/constants.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _deviceToken;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((value) {
      if(value.getString('token') != null){
        Future.delayed(const Duration(seconds: 3)).then((value) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainPanel(),
              ));
        });
      }else{
        Future.delayed(const Duration(seconds: 3)).then((value) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ));
        });
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          color: Colors.white,
          height: getHeight(context),
          width: getWidth(context),
          child: SafeArea(
              child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 220,
                    margin: const EdgeInsets.only(bottom: 100),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/logo.png"))),
                  )
                ],
              ),
              const Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                        strokeWidth: 5,
                      ),
                    ),
                  ))
            ],
          ))),
    );
  }
}
