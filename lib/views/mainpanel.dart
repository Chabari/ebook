import 'package:ebookapp/helpers/constants.dart';
import 'package:ebookapp/views/featured.dart';
import 'package:ebookapp/views/home.dart';
import 'package:ebookapp/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';

import '../helpers/mainpanelcontroller.dart';
import 'genre.dart';

class MainPanel extends StatelessWidget {
  final controller = Get.put(MainPanelController());
  
  @override
  Widget build(context) => GetBuilder<MainPanelController>(
      builder: (_) =>  Scaffold(
      backgroundColor: primaryColor,
      body: SizedBox(
        height: getHeight(context),
        width: getWidth(context),
        child: PageView(
          controller: _.pageController,
          onPageChanged: (index) => _.setScreen(index),
          scrollDirection: Axis.horizontal,
          children: [
            Home(),
            Featured(),
            Genre(),
            Profile()
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        color: Colors.white,
        child: RollingBottomBar(
          color: Colors.white,
          controller: _.pageController,
          items: const [
            RollingBottomBarItem(
              Icons.home,
              label: 'Home',
            ),
            RollingBottomBarItem(Icons.category, label: 'Featured'),
            RollingBottomBarItem(Icons.shopping_cart_outlined, label: 'Genres'),
            RollingBottomBarItem(Icons.person, label: 'Account'),
          ],
          activeItemColor: Colors.green.shade700,
          enableIconRotation: true,
          onTap: (index) {
            _.animateTo(
              index
            );
          },
        ),
      ),
  ));
  
}
