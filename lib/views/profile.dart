import 'dart:convert';

import 'package:ebookapp/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../data/userrepo.dart';

class Profile extends StatefulWidget {
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final userRepo = Get.find<UserRepoController>();
  int activeSubscription = 0;
  int purchasedBooks = 0;
  Widget _image(String asset) {
    return Image.asset(
      asset,
      height: 30.0,
      width: 30.0,
      color: Colors.amber,
    );
  }

  bool selected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBook();
  }

  void getBook() async {
    var response = await http.get(
      Uri.parse("${mainUrl}getMyProfile"),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userRepo.getUserToken()}',
      },
    );
    Map<String, dynamic> json1 = json.decode(response.body);
    setState(() {
      activeSubscription = json1['usersub'] ?? 0;
      purchasedBooks = json1['purchase'] ?? 0;
    });
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'African Ink',
        text:
            'Try African Ink today to read your favourite novel on your phone',
        linkUrl: 'african ink ',
        chooserTitle: 'Choose platform to share');
  }

  _launchWhatsapp(action) async {
    var whatsappAndroid = Uri();

    whatsappAndroid = Uri.parse("tel:${userRepo.getCallInfo()}");

    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }

  _sendMail() async {
    var uri1 = 'mailto:${userRepo.getEmailIngo()}?subject=Greetings&body=Hello';
    var uri = Uri.parse(uri1);
    try {
      await canLaunchUrl(uri);
      await launchUrl(uri);
    } on Exception catch (exception) {
      print(exception.toString());
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: primaryColor,
      body: SizedBox(
        height: getHeight(context),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_back_ios, color: Colors.white),
                        Text(
                          "Profile",
                          style: titleText4.copyWith(color: Colors.white),
                        ),
                        const Spacer(),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed('/editprofile');
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Edit",
                                    style: subtitle3.copyWith(),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Expanded(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32))),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),

                          const SizedBox(
                            height: 60,
                          ),
                          Text(
                            userRepo.getUserName(),
                            style: titleText2.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            userRepo.getEmail(),
                            style: subtitle4.copyWith(color: Colors.grey),
                          ),
                          //  const SizedBox(
                          //   height: 10,
                          // ),

                          // Padding(
                          //   padding: const EdgeInsets.all(10.0),
                          //   child: Row(
                          //     children: [
                          //       Expanded(child: Card(
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(10)
                          //         ),
                          //         elevation: 3,
                          //         child: Padding(
                          //           padding: const EdgeInsets.all(12.0),
                          //           child: Row(
                          //             children: [
                          //               const Icon(Icons.card_giftcard),
                          //               const SizedBox(width: 8,),
                          //               Text(
                          //                 "Earn Rewards",
                          //                 style: subtitle3.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       )),
                          //       Expanded(child: Card(
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(10)
                          //         ),
                          //         elevation: 3,
                          //         child: Padding(
                          //           padding: const EdgeInsets.all(12.0),
                          //           child: Row(
                          //             children: [
                          //               const Icon(Icons.wallet),
                          //               const SizedBox(width: 8,),
                          //               Text(
                          //                 "Top Up",
                          //                 style: subtitle3.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ))
                          //     ],
                          //   ),
                          // )
                          // ,
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Books Purchased",
                                        style: subtitle4.copyWith(
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        purchasedBooks.toString(),
                                        style: titleText2.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      Text(
                                        "Active Subscriptions",
                                        style: subtitle4.copyWith(
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        activeSubscription.toString(),
                                        style: titleText2.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 100,
                              width: getWidth(context),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/books/promo2.jpeg"),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 3,
                              child: InkWell(
                                onTap: () => share(),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.share),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Share with friends",
                                        style: subtitle2.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0).copyWith(top: 0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 3,
                              child: InkWell(
                                onTap: () => Get.toNamed('/mysubscriptions'),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.room_preferences),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Subscriptions",
                                        style: subtitle2.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0).copyWith(top: 0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 3,
                              child: InkWell(
                                onTap: () => Get.toNamed('/purchasedbooks'),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.settings),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "My Purchases",
                                        style: subtitle2.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0).copyWith(top: 0),
                          //   child: Card(
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(10)),
                          //     elevation: 3,
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(12.0),
                          //       child: Row(
                          //         children: [
                          //           const Icon(Icons.notifications),
                          //           const SizedBox(
                          //             width: 10,
                          //           ),
                          //           Text(
                          //             "Notifications",
                          //             style: subtitle2.copyWith(
                          //                 color: Colors.black,
                          //                 fontWeight: FontWeight.bold),
                          //           ),
                          //           const Spacer(),
                          //           const Icon(
                          //             Icons.arrow_forward_ios,
                          //             color: Colors.grey,
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 3,
                            margin: const EdgeInsets.all(4),
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  selected = !selected;
                                });
                              },
                              leading: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Icon(
                                  Icons.help,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                "Help & Support",
                                style: GoogleFonts.raleway(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              subtitle: selected
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Get help from our Customer center",
                                          style: GoogleFonts.raleway(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        InkWell(
                                          onTap: () => _sendMail(),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              const Icon(
                                                Icons.email,
                                                color: primaryColor,
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text("Email: ",
                                                  style: GoogleFonts.lato(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey)),
                                              Text(userRepo.getEmailIngo(),
                                                  style: GoogleFonts.lato(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        InkWell(
                                          onTap: () => _launchWhatsapp('c'),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              const Icon(
                                                Icons.phone_in_talk,
                                                color: primaryColor,
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text("Call Us: ",
                                                  style: GoogleFonts.lato(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey)),
                                              Text(userRepo.getCallInfo(),
                                                  style: GoogleFonts.lato(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        )
                                      ],
                                    )
                                  : Text(
                                      "Get help from our Customer center",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                              trailing: selected
                                  ? const Icon(Icons.arrow_drop_down_rounded)
                                  : const Icon(
                                      Icons.arrow_forward_ios_outlined),
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
              Positioned(
                  top: 80,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            image: AssetImage("assets/images/usericon.png")),
                        border: Border.all(color: Colors.white, width: 4)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
