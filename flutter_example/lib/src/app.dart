import 'package:flutter/material.dart';
import 'package:flutter_example/src/controller/app_controller.dart';
import 'package:flutter_example/src/pages/explore.dart';
import 'package:flutter_example/src/pages/library.dart';
import 'package:flutter_example/src/pages/subscribe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'pages/home.dart';

class App extends GetView<AppController> {
  @override
  Widget build(BuildContext context) {
    print('APP BUILD!!!');
    return Scaffold(
      body: Obx(() {
        switch (RouteName.values[controller.currentIndex.value]) {
          case RouteName.Home:
            return Home();
            break;
          case RouteName.Explore:
            return Explore();
            break;
          case RouteName.Subscribe:
            return Subscribe();
            break;
          case RouteName.Library:
            return Library();
            break;
          case RouteName.Add:
            // bottom sheet
            break;
        }
        return Container();
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.currentIndex.value,
          onTap: controller.ChangePageIndex,
          selectedItemColor: Colors.black,
          showSelectedLabels: true,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/icons/home_off.svg',
                ),
                activeIcon: SvgPicture.asset(
                  'assets/svg/icons/home_on.svg',
                ),
                label: "홈"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/icons/compass_off.svg',
                  width: 22,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/svg/icons/compass_on.svg',
                  width: 22,
                ),
                label: "탐색"),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    'assets/svg/icons/plus.svg',
                    width: 35,
                  ),
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/svg/icons/subs_off.svg'),
                activeIcon: SvgPicture.asset('assets/svg/icons/subs_on.svg'),
                label: "구독"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/svg/icons/library_off.svg'),
                activeIcon: SvgPicture.asset('assets/svg/icons/library_on.svg'),
                label: "보관함"),
          ],
        ),
      ),
    );
  }
}
