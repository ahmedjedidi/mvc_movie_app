import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_movie_app/controller/movies_controller.dart';
import 'package:mvc_movie_app/utils/constantes.dart';
import '../utils/colors.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  FavoritePageState createState() => FavoritePageState();
}

class FavoritePageState extends State<FavoritePage> {
  final MoviesController moviesController = Get.put(MoviesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: HexColor.fromHex("#373636"),
          centerTitle: true,
          title: Text(
            "Favoris",
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
          ),
        ),
        body: Obx(() {
          if (moviesController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (moviesController.moviesListFav.isEmpty) {
            return Align(
                alignment: Alignment.center,
                child: Text(
                  "Ajoutez des films aux favoris",
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  )),
                  textAlign: TextAlign.center,
                ));
          } else {
            return Column(children: [
              Flexible(
                  child: GridView.builder(
                cacheExtent: 9999,
                itemCount: moviesController.moviesListFav.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1.0,
                    childAspectRatio: 0.70,
                    mainAxisSpacing: 20.0),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Stack(
                          alignment: Alignment.topRight,
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: Constantes.baseUrlImage +
                                  moviesController
                                      .moviesListFav[index].posterPath,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress)),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  (moviesController.moviesListFav[index]
                                          .isFavorite.value)
                                      ? "assets/heart-fill.svg"
                                      : "assets/heart.svg",
                                ),
                                onPressed: () {
                                  moviesController.favorite(
                                      moviesController.moviesListFav[index]);
                                },
                              ),
                            ),
                          ]));
                },
              ))
            ]);
          }
        }));
  }
}
