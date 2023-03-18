import 'package:ebookapp/splashscreen.dart';
import 'package:ebookapp/views/bookdetails.dart';
import 'package:ebookapp/views/editprofile.dart';
import 'package:ebookapp/views/login.dart';
import 'package:ebookapp/views/mainpanel.dart';
import 'package:ebookapp/views/mysubscriptions.dart';
import 'package:ebookapp/views/purchasedBook.dart';
import 'package:ebookapp/views/readchapter.dart';
import 'package:ebookapp/views/readpdf.dart';
import 'package:ebookapp/views/resetpassword.dart';
import 'package:ebookapp/views/searchpage.dart';
import 'package:ebookapp/views/subscriptionplans.dart';
import 'package:ebookapp/views/viewchapters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/userrepo.dart';
import 'helpers/mainpanelcontroller.dart';
import 'helpers/ordersuccess.dart';
import 'views/categorydetails.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initdependencies();
  await FlutterDownloader.initialize(
    debug: true, // optional: set to false to disable printing logs to console (default: true)
    ignoreSsl: true // option: set to false to disable working with http links (default: false)
  );
  runApp(const MyApp());
}

Future initdependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => UserRepoController(sharedPreferences: Get.find()));
  Get.lazyPut(() => MainPanelController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return GetMaterialApp(
      initialRoute: '/splash',
      defaultTransition: Transition.cupertino,
      getPages: [
        GetPage(
            name: '/login',
            page: () => Login(),
            customTransition: SizeTransitions()),
        GetPage(
            name: '/mainpanel',
            page: () => MainPanel(),
            customTransition: SizeTransitions()),
        GetPage(
            name: '/splash',
            page: () => SplashScreen(),
            customTransition: SizeTransitions()),

        GetPage(
            name: '/subscription',
            page: () => SubscriptionPlans(),
            customTransition: SizeTransitions()),

        GetPage(
            name: '/categorydetails',
            page: () => CategoryDetails(),
            customTransition: SizeTransitions()),

        GetPage(
            name: '/bookdetails',
            page: () => BookDetails(),
            customTransition: SizeTransitions()),
        GetPage(
            name: '/ordersuccess',
            page: () => OrderSuccess(),
            customTransition: SizeTransitions()),
        GetPage(
            name: '/readchapter',
            page: () => ReadChapter(),
            customTransition: SizeTransitions()),
        GetPage(
            name: '/viewchapter',
            page: () => ViewChapters(),
            customTransition: SizeTransitions()),
        GetPage(
            name: '/readpdf',
            page: () => ReadPDF(),
            customTransition: SizeTransitions()),
        GetPage(
            name: '/editprofile',
            page: () => EditProfile(),
            customTransition: SizeTransitions()),
        GetPage(
            name: '/mysubscriptions',
            page: () => MySubscriptions(),
            customTransition: SizeTransitions()),
        GetPage(
            name: '/purchasedbooks',
            page: () => PurchasedBooks(),
            customTransition: SizeTransitions()),
        GetPage(
            name: '/resetpassword',
            page: () => ResetPassword(),
            customTransition: SizeTransitions()),
        GetPage(
            name: '/searchpage',
            page: () => SearchPage(),
            customTransition: SizeTransitions()),
      ],
    );
  }
}


class SizeTransitions extends CustomTransition {
  @override
  Widget buildTransition(
      BuildContext context,
      Curve? curve,
      Alignment? alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return Align(
      alignment: Alignment.center,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animation,
          curve: curve!,
        ),
        child: child,
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
