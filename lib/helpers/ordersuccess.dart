import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class OrderSuccess extends StatefulWidget {
  _OrderSuccessState createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  String? token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: getHeight(context),
        width: getWidth(context),
        child: SafeArea(
            child: Container(
          color: primaryColor,
          child: Column(
            children: [
              Expanded(
                  child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32))),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: getWidth(context),
                      child: Image.asset(
                        "assets/success.gif",
                        height: 250.0,
                        width: 250.0,
                      ),
                    ),
                    Text(
                      "Awesome!",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      "Request has been sent successfully",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "An mpesa popup will appear in a few. Kindly provide mpesa pin and click done to continue",
                      style: GoogleFonts.montserrat(
                          fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              )),
              SizedBox(
                height: 200,
                width: getWidth(context),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Your tracking number is",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white70),
                    ),
                    Text(
                      "#${Get.arguments[0]}",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 3,
                        color: primaryColor,
                        child: InkWell(
                          onTap: () {
                            Get.offNamed('/mainpanel');
                            
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "Done",
                                style: titleText4.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
