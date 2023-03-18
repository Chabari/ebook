import 'package:ars_progress_dialog/dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebookapp/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../data/userrepo.dart';
import '../helpers/bookdetailsscontroller.dart';
import '../helpers/homecontroller.dart';
import '../helpers/purchasedbookscontroller.dart';
import '../helpers/subscriptionplanscontroller.dart';
import '../helpers/usersubscriptions.dart';

class PurchasedBooks extends StatefulWidget {
  _PurchasedBooksState createState() => _PurchasedBooksState();
}

class _PurchasedBooksState extends State<PurchasedBooks> {
  final homectl = Get.put(PurchasedBookController());
  // final mhome = Get.put(HomeController());
  final mhome = Get.put(BookDetailsController());
  final UserRepoController ctrl = Get.find();

  @override
  Widget build(context) => GetBuilder<PurchasedBookController>(
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
                            "My Purchases",
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
                          _.purchasedbooksList.length > 0 ?
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _.purchasedbooksList.length,
                            itemBuilder: (context, index) => Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child:InkWell(
                                  onTap: () {
                                   
                                    mhome.getBook(_.purchasedbooksList[index]
                                        .book
                                        .id
                                        .toString());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            CachedNetworkImage(
                                              height: 70,
                                              width: 70,
                                              imageUrl: imageUrl +
                                                  _.purchasedbooksList[index].book.photo,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              progressIndicatorBuilder: (context,
                                                      url, downloadProgress) =>
                                                  Container(
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                              color: primaryColor,
                                                              value:
                                                                  downloadProgress
                                                                      .progress)),
                                                ),
                                              ),
                                              errorWidget: (context, url, error) =>
                                                  const Icon(Icons.error),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _.purchasedbooksList[index].book.title,
                                                  style: subtitle3.copyWith(
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                // Padding(
                                                // padding:
                                                //     const EdgeInsets.all(8.0).copyWith(top: 0),
                                                // child:
                                                //     Html(
                                                //       data: _.genrelist!.booklists[index].introduction)),
                                                Text(
                                                  ctrl.removeAllHtmlTags(_
                                                      .purchasedbooksList[index].book
                                                      .introduction),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: subtitle3.copyWith(
                                                      color: Colors.grey),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  width: 150,
                                                        margin: const EdgeInsets
                                                                .only(
                                                            right: 8),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    20),
                                                            color:
                                                                primaryColor),
                                                        child:
                                                            Padding(
                                                          padding: const EdgeInsets.all(
                                                                  4.0)
                                                              .copyWith(
                                                                  left:
                                                                      8,
                                                                  right:
                                                                      8),
                                                          child:
                                                              Center(
                                                            child:
                                                                Text(
                                                              _
                                                                  .purchasedbooksList[index].book.genreName,
                                                              style: smallText.copyWith(
                                                                  color:
                                                                      Colors.white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),


                                                  ],
                                            ))
                                          ],
                                        ),
                                        const Divider(),

                                        Row(
                                          children: [
                                            Expanded(child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        "Ksh",
                                                        style: subtitle4.copyWith(color: Colors.grey),
                                                      ),
                                                      Text(
                                                        _.purchasedbooksList[index].amount,
                                                        style: subtitle.copyWith(),
                                                      ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4,),
                                                Text(
                                                    "Amount",
                                                    style: subtitle3.copyWith(color: Colors.grey),
                                                  ),
                                               ],
                                            )),
                                            Expanded(child: Column(
                                              children: [
                                                Text(
                                                    getdatedate(_.purchasedbooksList[index].createdAt),
                                                    style: subtitle.copyWith(),
                                                  ),
                                                const SizedBox(height: 4,),
                                                Text(
                                                    "Date",
                                                    style: subtitle3.copyWith(color: Colors.grey),
                                                  ),
                                               ],
                                            )),
                                            Expanded(child: Column(
                                              children: [
                                                Container(
                                                  decoration:  BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: _.purchasedbooksList[index].status == "paid" ? Colors.green : Colors.red,

                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(0).copyWith(left: 20, right: 20),
                                                    child: Text(
                                                        _.purchasedbooksList[index].status,
                                                        style: subtitle.copyWith(color: Colors.white),
                                                      ),
                                                  ),
                                                ),
                                                const SizedBox(height: 4,),
                                                Text(
                                                    "Status",
                                                    style: subtitle3.copyWith(color: Colors.grey),
                                                  ),
                                               ],
                                            ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
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
                            ) : Center(child: Text("No Purchases available", style: subtitle.copyWith(color: Colors.grey),)),
                          
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
