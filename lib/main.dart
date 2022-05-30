import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mvc_movie_app/View/home_page.dart';
import 'package:mvc_movie_app/utils/colors.dart';

void main() {
  runApp(GetMaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.dark(
        primary: HexColor.fromHex("#FB0000"),
      ),
    ),
    title: 'Movie_App',
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
  ));
}
