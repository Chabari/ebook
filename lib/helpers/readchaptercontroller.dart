import 'package:ebookapp/data/genreslist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

import 'package:http/http.dart' as http;
import '../data/booklist.dart';
import '../data/userrepo.dart';
import 'constants.dart';

class ReadChapterController extends GetxController {
  FreeChapter? freechapter;
  void setChapter(free) {
    freechapter = free;
    update();
  }
}
