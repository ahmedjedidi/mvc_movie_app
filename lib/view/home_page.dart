import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mvc_movie_app/View/favorite_page.dart';
import 'package:mvc_movie_app/View/movies_page.dart';
import 'package:mvc_movie_app/controller/home_controller.dart';

import '../utils/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(() => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(13), topLeft: Radius.circular(13)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(13.0),
            topRight: Radius.circular(13.0),
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: landingPageController.changeTabIndex,
            currentIndex: landingPageController.tabIndex.value,
            backgroundColor: HexColor.fromHex("#373636"),
            items: [
              BottomNavigationBarItem(
                icon: (landingPageController.tabIndex.value == 0)
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: HexColor.fromHex("#FB0000"),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        height: 35,
                        width: 35,
                        child: SvgPicture.asset("assets/home-on.svg"))
                    : SvgPicture.asset("assets/home.svg"),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: (landingPageController.tabIndex.value == 1)
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: HexColor.fromHex("#FB0000"),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        height: 35,
                        width: 35,
                        child: SvgPicture.asset("assets/heart-on.svg"))
                    : SvgPicture.asset("assets/heart.svg"),
                label: '',
              ),
            ],
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: HexColor.fromHex("#373636")));

    final HomePageController landingPageController =
        Get.put(HomePageController(), permanent: false);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar:
          buildBottomNavigationMenu(context, landingPageController),
      body: Obx(() => IndexedStack(
            index: landingPageController.tabIndex.value,
            children: const [MoviesPage(), FavoritePage()],
          )),
    ));
  }
}
