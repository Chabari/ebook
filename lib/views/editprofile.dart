import 'package:ebookapp/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/userprofilecontroller.dart';

class EditProfile extends StatefulWidget {
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final controller = Get.put(UserProfileController());
  
   @override
  Widget build(context) => GetBuilder<UserProfileController>(
      builder: (_) => Scaffold(
      backgroundColor: primaryColor,
      body: SizedBox(
        height: getHeight(context),
        width: getWidth(context),
        child: SafeArea(child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(
              children: [
                Form(
                  key: _.formKey,
                  child: Column(
                    children: [
                      Container(
                        width: getWidth(context),
                        height: 180,
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                            bottomRight: Radius.circular(100)
                          ),
                
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 10,),
                            InkWell(
                              onTap: () => Get.back(),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: const Padding(
                                  padding:  EdgeInsets.all(8.0),
                                  child:  Icon(Icons.arrow_back, color: Colors.white, size: 35,),
                                )),
                            ),
                            Text("Edit Profile", style: titleText3.copyWith(color: Colors.white),),
                            const SizedBox(height: 20,),
                
                          ],
                        ),
                      ),
                            const SizedBox(height: 60,),
                
                      Card(
                        margin: const EdgeInsets.all(10).copyWith(top: 5),
                        elevation: 3,
                        shape:  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32)),
                                
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                            child: TextFormField(
                              cursorColor: primaryColor,
                              keyboardType: TextInputType.text,
                              style: GoogleFonts.raleway(
                                fontSize: 18,
                                color: primaryColor
                              ),
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
                      ),
                      
                      Card(
                        margin: const EdgeInsets.all(10).copyWith(top: 5),
                        elevation: 3,
                        shape:  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32)),
                                
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                            child: TextFormField(
                              cursorColor: primaryColor,
                              keyboardType: TextInputType.text,
                              style: GoogleFonts.raleway(
                                fontSize: 18,
                                color: primaryColor
                              ),
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
                      ),
                      
                      
                      Card(
                        margin: const EdgeInsets.all(10).copyWith(top: 5),
                        elevation: 3,
                        shape:  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32)),
                                
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                            child: TextFormField(
                              cursorColor: primaryColor,
                              keyboardType: TextInputType.number,
                              style: GoogleFonts.raleway(
                                fontSize: 18,
                                color: primaryColor
                              ),
                              
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
                                counterText: "",
                                contentPadding: const EdgeInsets.all(12),
                                hintText: "Phone Number",
                                hintStyle: GoogleFonts.raleway(
                                    color: primaryColor, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    Card(
                        margin: const EdgeInsets.all(10).copyWith(top: 5),
                        elevation: 3,
                        shape:  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32)),
                                
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
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
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.black87,
                                ),
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
                      ),
                    Card(
                        margin: const EdgeInsets.all(10).copyWith(top: 5),
                        elevation: 3,
                        shape:  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32)),
                                
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                            child: TextFormField(
                              cursorColor: primaryColor,
                              keyboardType: TextInputType.number,
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
                                  Icons.crop_landscape_outlined,
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
                      ),
          
                      const SizedBox(height: 20,),
          
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
                  )
                    
                    ],
                  ),
                ),
                Positioned(
                  top: 120,
                  left: 50,
                  right: 50,
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            image: const DecorationImage(image: AssetImage('assets/images/usericon.png'))
                          ),
                         
                        ),
                        const Positioned(
                          right: 4,
                          bottom: 6,
                          child: Icon(Icons.add_photo_alternate))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    ));
  
}
