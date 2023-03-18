import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

const Color colorAcent = Colors.black;
const Color primaryColor = Color(0xFF521814);
const Color secondaryColor = Color(0xFFffffff);

const kGoogleApiKey = "AIzaSyCUwQCkzVToSTN9PCH2KKuIO9MjCBzS1as";

// const mainUrl = "https://delivery.campdavidbutchery.com/api/";
// const imageUrl = "https://delivery.campdavidbutchery.com/storage/";

const mainUrl = "https://africaninkpublishers.com/public/api/";
const imageUrl = "https://africaninkpublishers.com/public/uploads/";
// const imageUrl = "http://192.168.0.105/afrikanink/public/uploads/";

const kAnimationDuration = Duration(milliseconds: 200);

double getHeight(context) {
  return MediaQuery.of(context).size.height;
}

double getWidth(context) {
  return MediaQuery.of(context).size.height;
}

String getdatedate(DateTime dat) {
  String formated = DateFormat('dd-MM-yyyy').format(dat).toString();
  return formated;
}

String getdatedatetime(DateTime dat) {
  String formated = DateFormat('dd-MM-yyyy HH:mm a').format(dat).toString();
  return formated;
}

String getdatestringformat(String date) {
  DateTime dat = DateTime.parse(date);
  if (dat.day == DateTime.now().day && dat.month == DateTime.now().month) {
    return "Today";
  }
  String formated = DateFormat.MMMd().format(dat).toString();

  return formated;
}

String makelist() {
  return "";
}

// oswald
// raleway
// roboto
// playfairDisplay
// garamond
// merriweather

final List<String> imgList = [
  'assets/books/promo.jpg',
  'assets/books/promo1.jpg',
  'assets/books/promo2.jpeg',
  'assets/books/promo3.png',
  'assets/books/promo4.jpg',
  'assets/books/promo5.jpg'
];

final titleText = GoogleFonts.raleway(
  fontSize: 42,
  fontWeight: FontWeight.bold,
);

final titleText1 = GoogleFonts.raleway(
  fontSize: 32,
  fontWeight: FontWeight.bold,
);

final titleText2 = GoogleFonts.raleway(
  fontSize: 28,
  fontWeight: FontWeight.bold,
);

final titleText3 = GoogleFonts.raleway(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

final titleText4 = GoogleFonts.raleway(
  fontSize: 22,
  fontWeight: FontWeight.bold,
);

final subtitle = GoogleFonts.raleway(
  fontSize: 20,
);

final subtitle1 = GoogleFonts.raleway(
  fontSize: 18,
);

final subtitle2 = GoogleFonts.raleway(
  fontSize: 16,
);

final subtitle3 = GoogleFonts.raleway(
  fontSize: 14,
);

final subtitle4 = GoogleFonts.raleway(
  fontSize: 12,
);

final smallText = GoogleFonts.raleway(
  fontSize: 10,
);
