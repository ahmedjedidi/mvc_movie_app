import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_movie_app/controller/movies_controller.dart';
import 'package:mvc_movie_app/utils/colors.dart';
import 'package:mvc_movie_app/utils/constantes.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  MoviesPageState createState() => MoviesPageState();
}

class MoviesPageState extends State<MoviesPage> {
  final MoviesController moviesController = Get.put(MoviesController());
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: HexColor.fromHex("#373636"),
          title: Image.asset(
            "assets/Moovi-logo.png",
            width: 100,
          ),
        ),
        body: Obx(() {
          if (moviesController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        moviesController.runFilter(value);
                      },
                      controller: editingController,
                      decoration: const InputDecoration(
                          labelText: "Search",
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      height: 100,
                      child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(width: 15);
                          },
                          itemCount: moviesController.categoriesList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(children: [
                              Container(
                                  width: 64.0,
                                  height: 64.0,
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: HexColor.fromHex("#FB0000"),
                                      shape: BoxShape.circle),
                                  child: SvgPicture.asset(moviesController
                                          .categoriesList[index].image ??
                                      "")),
                              const SizedBox(height: 10),
                              Center(
                                  child: Text(
                                moviesController.categoriesList[index].name ??
                                    "",
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                )),
                              ))
                            ]);
                          })),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Recommandés",
                              style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                            ),
                            Text(
                              "Voir tout",
                              style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              )),
                            )
                          ])),
                  Flexible(
                      child: GridView.builder(
                    cacheExtent: 9999,
                    itemCount: moviesController.moviesList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1.0,
                            childAspectRatio: 0.75,
                            mainAxisSpacing: 20.0),
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                          alignment: Alignment.topRight,
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: Constantes.baseUrlImage +
                                  moviesController.moviesList[index].posterPath,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress)),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            Obx((() => Positioned(
                                  right: 0,
                                  child: IconButton(
                                    icon: SvgPicture.asset(
                                      (moviesController.moviesList[index]
                                              .isFavorite.value)
                                          ? "assets/heart-fill.svg"
                                          : "assets/heart-on.svg",
                                    ),
                                    onPressed: () {
                                      moviesController.favorite(
                                          moviesController.moviesList[index]);
                                    },
                                  ),
                                ))),
                          ]);
                    },
                  ))
                ]);
          }
        }));
  }
}
