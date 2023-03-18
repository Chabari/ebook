import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/bookdetailsscontroller.dart';
import '../helpers/constants.dart';
import '../helpers/homecontroller.dart';

class BookDetails extends StatefulWidget {
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  final controller = Get.put(BookDetailsController());
  final homectl = Get.put(HomeController());

  int seleted = 0;

  Widget _image(String asset) {
    return Image.asset(
      asset,
      height: 30.0,
      width: 30.0,
      color: Colors.amber,
    );
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
                                 seleted == 1 ? Icons.radio_button_checked :
                                Icons.radio_button_off,
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
                                 seleted == 2 ? Icons.radio_button_checked :
                                Icons.radio_button_off,
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
                          controller.purchase(
                              homectl.selectedBookList!.id, seleted);
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
                            "Purchase",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold, fontSize: 18, color: seleted != 0 ? Colors.white : primaryColor),
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
  Widget build(context) => GetBuilder<BookDetailsController>(
      builder: (_) => Scaffold(
          backgroundColor: primaryColor,
          body: SizedBox(
            height: getHeight(context),
            width: getWidth(context),
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
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(Icons.arrow_back_ios,
                                  color: Colors.white)),
                          Text(
                            "Book Details",
                            style: titleText4.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 90,
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
                            Row(
                              children: [
                                const SizedBox(
                                  width: 130,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Author: ${homectl.selectedBookList!.author_name}",
                                      style: subtitle1,
                                    ),
                                    Text(
                                      homectl.selectedBookList!.genre_name,
                                      style: subtitle1.copyWith(
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      "${homectl.selectedBookList!.chapters} Chapters",
                                      style: subtitle3,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RatingBar(
                                      initialRating: 3,
                                      itemSize: 15,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      ratingWidget: RatingWidget(
                                        full: _image('assets/heart.png'),
                                        half: _image('assets/heart_half.png'),
                                        empty:
                                            _image('assets/heart_border.png'),
                                      ),
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ],
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                homectl.selectedBookList!.authersNote,
                                style: subtitle4.copyWith(color: Colors.grey),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 15,
                                  width: 4,
                                  decoration:
                                      const BoxDecoration(color: primaryColor),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "Introduction",
                                  style: titleText4,
                                ),
                              ],
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.all(8.0).copyWith(top: 0),
                                child: Html(
                                    data: homectl
                                        .selectedBookList!.introduction)),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Text(
                            //     "Flashy mission statements that ultimately do little to motivate employees and less to impress customers, investors, and partners Many corporations have slick, flashy mission statements that ultimately do little to motivate employees and less to impress customers, investors, and partners.",
                            //     style: subtitle4,
                            //   ),
                            // ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (homectl.selectedBookList!.freeChapters.length >
                                0)
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 2,
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed('/viewchapter');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Book Contents",
                                                style: titleText4,
                                              ),
                                            ),
                                            Text(
                                              "${homectl.selectedBookList!.chapters} Chapters",
                                              style: subtitle3,
                                            ),
                                            const Icon(Icons.arrow_forward_ios)
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "View all the chapters for this book",
                                          style: subtitle3,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            const SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
                Positioned(
                    top: 90,
                    left: 20,
                    right: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          height: 150,
                          width: 90,
                          imageUrl: imageUrl + homectl.selectedBookList!.photo,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Container(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: Center(
                                  child: CircularProgressIndicator(
                                      color: primaryColor,
                                      value: downloadProgress.progress)),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        // Container(
                        //   height: 150,
                        //   width: 90,
                        //   decoration: const BoxDecoration(
                        //       image: DecorationImage(
                        //           image: AssetImage(
                        //               "assets/books/thecryingbook.png"))),
                        // ),
                        //const SizedBox(width: 10,),

                        Padding(
                          padding: const EdgeInsets.all(10.0).copyWith(top: 20),
                          child: Text(
                            homectl.selectedBookList!.title,
                            style: subtitle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        children: [
                          if (homectl.selectedBookList != null && _.isSuscribed)
                            Expanded(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: primaryColor,
                                elevation: 3,
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed('/readpdf');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0)
                                        .copyWith(left: 4, right: 4),
                                    child: Center(
                                      child: Text(
                                        "Read Now",
                                        style: subtitle2.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          else
                            Expanded(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: primaryColor,
                                elevation: 3,
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed('/subscription');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0)
                                        .copyWith(left: 4, right: 4),
                                    child: Center(
                                      child: Text(
                                        "Subscibe Now",
                                        style: subtitle2.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          if (_.isPurchased == false)
                            Expanded(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: Colors.white,
                                elevation: 3,
                                child: InkWell(
                                  onTap: () {
                                    // AwesomeDialog(
                                    //   context: context,
                                    //   dialogType: DialogType.info,
                                    //   animType: AnimType.rightSlide,
                                    //   title: 'Confirmation',
                                    //   desc:
                                    //       'Please confirm to purchace this book. @ Ksh ${homectl.selectedBookList!.cost}',
                                    //   btnCancelOnPress: () {},
                                    //   btnOkOnPress: () {
                                    //     _.purchase(
                                    //         homectl.selectedBookList!.id);
                                    //   },
                                    // ).show();
                                    _viewmoreModalBottomSheet(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0)
                                        .copyWith(left: 4, right: 4),
                                    child: Center(
                                      child: Text(
                                        "Buy @ Ksh ${homectl.selectedBookList!.cost}",
                                        style: subtitle2.copyWith(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          else
                            Expanded(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: Colors.white,
                                elevation: 3,
                                child: InkWell(
                                  onTap: () {
                                    controller.requestDownload(
                                        mainUrl +
                                            homectl.selectedBookList!.bookpath,
                                        "");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0)
                                        .copyWith(left: 4, right: 4),
                                    child: Center(
                                      child: Text(
                                        "Download Book",
                                        style: subtitle2.copyWith(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          // // const SizedBox(width: 20,),
                          // const Spacer(),
                          // Container(
                          // decoration: BoxDecoration(
                          //   shape: BoxShape.circle,
                          //   border: Border.all(color: Colors.grey)
                          // ),
                          // child: const Padding(
                          //   padding:  EdgeInsets.all(8.0),
                          //   child:  Icon(Icons.favorite_border),
                          // )),
                        ],
                      ),
                    ))
              ],
            )),
          )));
}
