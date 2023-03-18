import 'package:ebookapp/helpers/constants.dart';
import 'package:ebookapp/views/mainpanel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/featurescontroller.dart';
import '../helpers/logincontroller.dart';
import '../helpers/signuppagecontroller.dart';

class SignUp extends StatelessWidget {
  final controller = Get.put(SignUpController());

   SignUp({super.key});
  
   @override
  Widget build(context) => GetBuilder<SignUpController>(
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
                "Signup",
                style: titleText.copyWith(color: primaryColor),
              ),

              Padding(
                padding: const EdgeInsets.all(30.0).copyWith(top: 0),
                child: Text(
                  "Join the large community of novel lovers today by signing up to African Ink",
                  textAlign: TextAlign.center,
                  style: subtitle1.copyWith(color: Colors.grey),
                ),
              ),
              
              
                Card(
                  margin: const EdgeInsets.all(10).copyWith(top: 5),
                  elevation: 3,
                  shape:  RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                          
                  child: Center(
                    child: TextFormField(
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.text,
                      style: GoogleFonts.raleway(
                        fontSize: 18,
                        color: primaryColor
                      ),
                      validator: (value) => value!.isEmpty ? "First name cannot be null" : null,
                      controller: _.firstNameCOntroller,
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
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.black87,
                        ),
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        counterText: "",
                        contentPadding: const EdgeInsets.all(12),
                        hintText: "First Name",
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
                          
                  child: Center(
                    child: TextFormField(
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.text,
                      style: GoogleFonts.raleway(
                        fontSize: 18,
                        color: primaryColor
                      ),
                      validator: (value) => value!.isEmpty ? "Last name cannot be null" : null,
                      controller: _.lastNameCOntroller,
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
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.black87,
                        ),
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        counterText: "",
                        contentPadding: const EdgeInsets.all(12),
                        hintText: "Last Name",
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
                          
                  child: Center(
                    child: TextFormField(
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.raleway(
                        fontSize: 18,
                        color: primaryColor
                      ),
                      validator: (value) => value!.isEmpty ? "Email cannot be null" : null,
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
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.black87,
                        ),
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        labelText: "example@gmail.com",
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
                          
                  child: Center(
                    child: TextFormField(
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.phone,
                      style: GoogleFonts.raleway(
                        fontSize: 18,
                        color: primaryColor
                      ),
                      validator: (value) => value!.isEmpty ? "Phone Number cannot be null" : null,
                      controller: _.phoneCOntroller,
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
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.black87,
                        ),
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        labelText: "0xxxxxxxxx",
                        contentPadding: const EdgeInsets.all(12),
                        hintText: "Phone Number",
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
                          
                  child: Center(
                    child: TextFormField(
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.raleway(
                        fontSize: 18,
                        color: primaryColor
                      ),
                      controller: _.idNumberCOntroller,
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
                        prefixIcon: const Icon(
                          Icons.card_membership,
                          color: Colors.black87,
                        ),
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        counterText: "",
                        contentPadding: const EdgeInsets.all(12),
                        hintText: "Id Number",
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
                      validator: (value) => value!.isEmpty ? "Password cannot be null" : null,
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
                  
            ],
          ),
        ),
      )),
      ),
   ));
  
}
