import 'package:ebookapp/helpers/constants.dart';
import 'package:ebookapp/views/mainpanel.dart';
import 'package:ebookapp/views/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/featurescontroller.dart';
import '../helpers/logincontroller.dart';

class Login extends StatelessWidget {
  final controller = Get.put(LoginController());

   Login({super.key});
  
   @override
  Widget build(context) => GetBuilder<LoginController>(
      builder: (_) => Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(height: getHeight(context), width: getWidth(context),
      child: SafeArea(child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _.formKey,
          child: Column(
            children: [
              
              const SizedBox(height: 70,),
              Text(
                "Login",
                style: titleText.copyWith(color: primaryColor),
              ),
              
              const SizedBox(height: 20,),
              
              Container(
                height: 250,
                width: getWidth(context),
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/ebook.png"))
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
                Card(
                  margin: const EdgeInsets.all(10).copyWith(top: 5),
                  elevation: 3,
                  shape:  RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                          color: Colors.white,
                          
                  child: Center(
                    child: TextFormField(
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.text,
                      style: GoogleFonts.raleway(
                        fontSize: 18,
                        color: primaryColor
                      ),
                      controller: _.passwordCOntroller,
                      obscureText: _.isObscure,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                
                            color: Colors.white, width: 0.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(32))),
                        focusedBorder:  OutlineInputBorder(
                            borderSide: BorderSide(
                            color: primaryColor.withOpacity(0.3),),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        suffixIcon: InkWell(
                           onTap: () => _.setObscure(!_.isObscure),
                          child: Icon(
                            _.isObscure ? Icons.visibility_off : Icons.visibility,
                            color: primaryColor,
                          ),
                        ),
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        counterText: "",
                        contentPadding: const EdgeInsets.all(12),
                        hintText: "Password",
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
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () => Get.toNamed('/resetpassword'),
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Text(
                          "Forgot Password? ",
                          style: GoogleFonts.montserrat(
                              color: primaryColor, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SignUp(),
                          )),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an Account? ",
                            style: GoogleFonts.montserrat(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                          // SizedBox(width: 3,),
                          Text(
                            "Sign Up",
                            style: GoogleFonts.montserrat(
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
