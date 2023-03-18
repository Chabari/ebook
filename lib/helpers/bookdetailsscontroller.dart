import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:ars_progress_dialog/dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import '../data/booklist.dart';
import '../data/userrepo.dart';
import 'constants.dart';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:path_provider/path_provider.dart';

import 'homecontroller.dart';
import 'mainpanelcontroller.dart';


class BookDetailsController extends GetxController {
  var currentIndex = 1;
  var _localPath;
  final userRepo = Get.find<UserRepoController>();
  final homeCtl = Get.find<HomeController>();
  final mainpanel = Get.find<MainPanelController>();
  bool isSuscribed = false;
  bool isPurchased = false;

  String bookId = "0";
  
  late bool _saveInPublicStorage;

  late bool _permissionReady;

  ArsProgressDialog progressDialog = ArsProgressDialog(Get.context,
      blur: 2,
      backgroundColor: const Color(0x33000000),
      animationDuration: const Duration(milliseconds: 500));
  void setScreen(index) {
    currentIndex = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _saveInPublicStorage = false;

    FlutterDownloader.registerCallback(downloadCallback, step: 1);
    _permissionReady = false;
    _prepare();

    if (homeCtl.selectedBookList != null) {
      checkSubscription();
    }
  }


  void getBook(bookid) async {
    if (bookid != null) {
      progressDialog.show();
      var data = {
        'book_id': bookid,
      };
      var body = json.encode(data);
      var response = await http.post(Uri.parse("${mainUrl}get-my-book"),
          headers: {
            "Content-Type": "application/json",
            'Accept': 'application/json',
            'Authorization': 'Bearer ${userRepo.getUserToken()}',
          },
          body: body);
      progressDialog.dismiss();
      homeCtl.selectedBookList = BookList.fromJson(json.decode(response.body));
      checkSubscription();
      update();
      if (homeCtl.selectedBookList != null) {
        Get.toNamed('/bookdetails');
      }
    }
  }

  void checkSubscription() async {
    var data = {
      'book_id': homeCtl.selectedBookList!.id.toString(),
    };
    var body = json.encode(data);
    var response = await http.post(Uri.parse("${mainUrl}checkSubscribed"),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userRepo.getUserToken()}',
        },
        body: body);
    print(response.body);
    Map<String, dynamic> json1 = json.decode(response.body);
    if (response.statusCode == 200) {
      if (json1['success'] == "1") {
        isSuscribed = json1['isSuscribed'];
        isPurchased = json1['isPurchased'];
        bookId = json1['bookId'];
        update();
      }
    }
  }

@pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    DownloadTaskStatus status,
    int progress,
  ) {
    print(
      'Callback on background isolate: '
      'task ($id) is in status ($status) and process ($progress)',
    );

    IsolateNameServer.lookupPortByName('downloader_send_port')
        ?.send([id, status, progress]);
  }
  
  void purchase(id, selected) async {
    progressDialog.show();
    var data = {
      'book_id': id.toString(),
      'selected': selected == 1 ? "Card" : "Mpesa"
    };
    var body = json.encode(data);
    var response = await http.post(Uri.parse("${mainUrl}purchase-book"),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userRepo.getUserToken()}',
        },
        body: body);
    Map<String, dynamic> json1 = json.decode(response.body);
    if (response.statusCode == 200) {
      progressDialog.dismiss();
      if (json1['success'] == "1") {
        showToast(json1['message'], Colors.green);
        mainpanel.setScreen(0);
        
        Get.offNamed('/ordersuccess', arguments: [json1['code']]);
      } else if (json1['success'] == "2") {
        showToast(json1['message'], Colors.red);
      } else {
        showToast(json1['message'], Colors.red);
      }
    } else { 
      progressDialog.dismiss();
      showToast(json1['message'], Colors.red);
    }
  }

  Future<void> requestDownload(link, taskId) async {
    taskId = await FlutterDownloader.enqueue(
      url: link,
      headers: {'auth': 'test_for_sql_encoding'},
      savedDir: _localPath,
      saveInPublicStorage: _saveInPublicStorage,
    );
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _getSavedDir())!;
    final savedDir = Directory(_localPath);
    if (!savedDir.existsSync()) {
      await savedDir.create();
    }
  }

  Future<String?> _getSavedDir() async {
    String? externalStorageDirPath;

    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (err, st) {
        print('failed to get downloads path: $err, $st');

        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }



  Future<bool> _checkPermission() async {
    if (Platform.isIOS) {
      return true;
    }

    if (Platform.isAndroid) {
      final info = await DeviceInfoPlugin().androidInfo;
      if (info.version.sdkInt > 28) {
        return true;
      }

      final status = await Permission.storage.status;
      if (status == PermissionStatus.granted) {
        return true;
      }

      final result = await Permission.storage.request();
      return result == PermissionStatus.granted;
    }

    throw StateError('unknown platform');
  }

  Future<void> _prepare() async {
    final tasks = await FlutterDownloader.loadTasks();

    if (tasks == null) {
      print('No tasks were retrieved from the database.');
      return;
    }

    _permissionReady = await _checkPermission();
    if (_permissionReady) {
      await _prepareSaveDir();
    }

  }

  void showToast(message, color) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
