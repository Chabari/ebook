import 'package:ebookapp/helpers/constants.dart';
import 'package:ebookapp/views/mainpanel.dart';
import 'package:ebookapp/views/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/featurescontroller.dart';
import '../helpers/logincontroller.dart';
import '../helpers/resetpasswordcontroller.dart';

class ResetPassword extends StatelessWidget {
  final controller = Get.put(ResetPassController());

   ResetPassword({super.key});
  
   @override
  Widget build(context) => GetBuilder<ResetPassController>(
      builder: (_) => Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(height: getHeight(context), width: getWidth(context),
      child: SafeArea(child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _.formKey,
          child: Column(
            children: [
              
              const SizedBox(height: 20,),
              InkWell(
                onTap: () => Get.back(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: const Icon(Icons.arrow_back, size: 35,)),
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                "Reset Password",
                style: titleText.copyWith(color: primaryColor),
              ),

              Text(
                "A password reset link will be sent to your email",
                style: GoogleFonts.raleway(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              
              const SizedBox(height: 20,),
              
              Container(
                height: 250,
                width: getWidth(context),
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/bizpat.png"))
                ),
                ),
                const SizedBox(height: 20,),
              
                Card(
                  margin: const EdgeInsets.all(10).copyWith(top: 5),
                  elevation: 3,
                  shape:  RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                          
                  child: Center(
                    child: TextFormField(
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.raleway(
                        fontSize: 18,
                        color: primaryColor
                      ),
                      controller: _.emailController,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                
                            color: Colors.white, width: 0.0),
                            borderRadius:
                                 BorderRadius.all(Radius.circular(32))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                            color: Colors.white,),
                            borderRadius:
                                 BorderRadius.all(Radius.circular(20))),
                        // prefixIcon: const Icon(
                        //   Icons.phone,
                        //   color: Colors.black87,
                        // ),
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        counterText: "",
                        contentPadding: const EdgeInsets.all(12),
                        hintText: "Email",
                        hintStyle: GoogleFonts.raleway(
                            color: primaryColor, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 30,),
              
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    elevation: 3,
                    color: primaryColor,
                    child: InkWell(
                      onTap: () => controller.validateSubmit(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                                "Submit",
                                style: titleText4.copyWith(color: Colors.white),
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                    height: 50,
                  ),
                  
                  Container(
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already an Account? ",
                            style: GoogleFonts.raleway(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                          // SizedBox(width: 3,),
                          Text(
                            "Login",
                            style: GoogleFonts.raleway(
                              color: primaryColor,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
            
            
            ],
          ),
        ),
      )),
      ),
   ));
  
}
