import 'package:ars_progress_dialog/dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ebookapp/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../helpers/bookdetailsscontroller.dart';
import '../helpers/homecontroller.dart';
import '../helpers/subscriptionplanscontroller.dart';
import '../helpers/usersubscriptions.dart';

class MySubscriptions extends StatefulWidget {
  _MySubscriptionsState createState() => _MySubscriptionsState();
}

class _MySubscriptionsState extends State<MySubscriptions> {
  final homectl = Get.put(UserSubscriptionsController());
  final mhome = Get.put(BookDetailsController());

  @override
  Widget build(context) => GetBuilder<UserSubscriptionsController>(
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
                            "My Subscription",
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
                        width: getWidth(context),
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
                          _.usersubscriptions.length > 0 ?
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _.usersubscriptions.length,
                            itemBuilder: (context, index) => Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0)
                                        .copyWith(bottom: 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            _.usersubscriptions[index]
                                                .subscription.title,
                                            style: subtitle.copyWith(
                                                color: primaryColor),
                                          ),
                                        ),
                                        Text(
                                          "Ksh ${_.usersubscriptions[index].amount}",
                                          style: subtitle.copyWith(
                                              color: primaryColor),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0)
                                        .copyWith(top: 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            getdatedate(_
                                                .usersubscriptions[index]
                                                .createdAt),
                                            style: subtitle3.copyWith(
                                                color: Colors.grey),
                                          ),
                                        ),
                                        Text(
                                          "${_.usersubscriptions[index].subscription.periodCount} ${_.usersubscriptions[index].subscription.period}",
                                          style: subtitle3.copyWith(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _.usersubscriptions[index].book
                                                .title,
                                            style: subtitle.copyWith(),
                                          ),
                                          Text(
                                            "Book By: ${_.usersubscriptions[index].book.authorName}",
                                            style: subtitle3.copyWith(),
                                          ),
                                        ],
                                      )),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        color: primaryColor,
                                        child: InkWell(
                                          onTap: () {
                                            mhome.getBook(_
                                                .usersubscriptions[index]
                                                .book
                                                .id
                                                .toString());
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "View Book",
                                              style: subtitle3.copyWith(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ),
                          )
                          : _.isLoading ? const SizedBox(
                              height: 60,
                              width: 60,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                  strokeWidth: 5,
                                ),
                              ),
                            ) : Center(child: Text("No Subscriptions available", style: subtitle.copyWith(color: Colors.grey),)),
                          
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ))
                ],
              )),
            ),
          ));
}
