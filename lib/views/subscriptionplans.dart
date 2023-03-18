import 'package:ars_progress_dialog/dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ebookapp/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/subscriptionplanscontroller.dart';

class SubscriptionPlans extends StatefulWidget {
  _SubscriptionPlansState createState() => _SubscriptionPlansState();
}

class _SubscriptionPlansState extends State<SubscriptionPlans> {
  final homectl = Get.put(SubscriptionPlanController());
  int seleted = 0;
  @override
  void initState() {
    super.initState();
    homectl.getplans().then((value) {});
  }

  void _viewmoreModalBottomSheet(context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (BuildContext bc) {
          return StatefulBuilder(
            builder: (context, setModalState) {
              return Container(
                padding: const EdgeInsets.all(8).copyWith(top: 15),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Select Payment Method",
                          style: GoogleFonts.raleway(fontSize: 17),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: InkWell(
                        onTap: () {
                          setModalState(() {
                            seleted = 1;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                seleted == 1
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_off,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  "Card",
                                  style: GoogleFonts.raleway(fontSize: 17),
                                ),
                              ),
                              Container(
                                width: 100,
                                height: 35,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/payments/payment-method.png'))),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: InkWell(
                        onTap: () {
                          setModalState(() {
                            seleted = 2;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                seleted == 2
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_off,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  "Mpesa",
                                  style: GoogleFonts.raleway(fontSize: 17),
                                ),
                              ),
                              Container(
                                width: 35,
                                height: 35,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/payments/mpesa.png'))),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        if (seleted != 0) {
                          homectl.purchase();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            color: seleted == 0 ? Colors.grey : primaryColor,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        height: height * 0.065,
                        child: Center(
                          child: Text(
                            "Subscribe",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color:
                                    seleted != 0 ? Colors.white : primaryColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(context) => GetBuilder<SubscriptionPlanController>(
      builder: (_) => Scaffold(
            backgroundColor: primaryColor,
            body: SizedBox(
              height: getHeight(context),
              width: getWidth(context),
              child: SafeArea(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () => Get.back(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                          Text(
                            "Subscription",
                            style: titleText4.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                            height: 20,
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 40,
                          ),
                          Text(
                            "GO PREMIUM",
                            style: subtitle.copyWith(color: Colors.grey),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.all(20.0).copyWith(top: 10),
                            child: Text(
                              "Pay only when you use the app. you can cancel this subscription",
                              textAlign: TextAlign.center,
                              style: subtitle2.copyWith(color: Colors.grey),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _.subscriptionlists.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  _.setPlan(_.subscriptionlists[index]);
                                },
                                child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                          color: _.selectedplan != null &&
                                                  _.selectedplan!.id ==
                                                      _.subscriptionlists[index]
                                                          .id
                                              ? primaryColor
                                              : Colors.white,
                                          width: 3)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            _.subscriptionlists[index].title,
                                            style: titleText4,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Ksh ${_.subscriptionlists[index].amount}",
                                              style: titleText4.copyWith(
                                                  color: primaryColor),
                                            ),
                                            Text(
                                              _.subscriptionlists[index]
                                                          .period ==
                                                      'lifetime'
                                                  ? _.subscriptionlists[index]
                                                      .period
                                                  : "${_.subscriptionlists[index].periodCount} ${_.subscriptionlists[index].period}",
                                              style: subtitle2.copyWith(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 3,
                              color: _.selectedplan != null
                                  ? primaryColor
                                  : Colors.grey,
                              child: InkWell(
                                onTap: () {
                                  if (_.selectedplan != null) {
                                    _viewmoreModalBottomSheet(context);
                                    // AwesomeDialog(
                                    //   context: context,
                                    //   dialogType: DialogType.info,
                                    //   animType: AnimType.rightSlide,
                                    //   title: 'Confirmation',
                                    //   desc:
                                    //       'Please confirm to purchace this subscription',
                                    //   btnCancelOnPress: () {},
                                    //   btnOkOnPress: () {
                                    //     _.purchase();
                                    //   },
                                    // ).show();
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      "Continue",
                                      style: titleText4.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
                ],
              )),
            ),
          ));
}
