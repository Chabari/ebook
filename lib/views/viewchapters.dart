import 'package:ebookapp/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/homecontroller.dart';
import '../helpers/readchaptercontroller.dart';

class ViewChapters extends StatefulWidget {
  _ViewChaptersState createState() => _ViewChaptersState();
}

class _ViewChaptersState extends State<ViewChapters> {
  final HomeController ctrl = Get.find();
  final readController = Get.put(ReadChapterController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  InkWell(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.arrow_back_ios,
                          color: Colors.white)),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                     ctrl.selectedBookList!.title,
                    style: titleText4.copyWith(color: Colors.white),
                  ),
                ],
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Contents",
                            style: subtitle2,
                          )),
                          const Icon(
                            Icons.download,
                            color: primaryColor,
                          ),
                          Text(
                            "Download",
                            style: subtitle2.copyWith(color: primaryColor),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: ctrl.selectedBookList!.freeChapters.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          readController.setChapter(
                              ctrl.selectedBookList!.freeChapters[index]);

                          Get.toNamed('/readchapter');
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Chapter ${ctrl.selectedBookList!.freeChapters[index]
                                        .chapter}",
                                    style: subtitle2.copyWith(),
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios)
                              ],
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
    );
  }
}
