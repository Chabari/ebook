import 'package:ebookapp/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../helpers/homecontroller.dart';
import '../helpers/readchaptercontroller.dart';

class ReadChapter extends StatefulWidget {
  _ReadChapterState createState() => _ReadChapterState();
}

class _ReadChapterState extends State<ReadChapter> {
  final HomeController ctrl = Get.find();
  final readController = Get.put(ReadChapterController());


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
          backgroundColor: primaryColor,
          body: SizedBox(height: getHeight(context),width: getWidth(context),
          child: SafeArea(child: Column(
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
                           "Chapter ${readController.freechapter!.chapter}",
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
                                padding:
                                    const EdgeInsets.all(8.0).copyWith(top: 0),
                                child: Html(
                                    data: readController
                                        .freechapter!.content)),
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
