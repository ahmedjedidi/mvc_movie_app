import 'package:get/get.dart';
import 'package:mvc_movie_app/Model/movies.dart';
import 'package:mvc_movie_app/model/categories.dart';
import 'package:mvc_movie_app/services/remote_service.dart';

class MoviesController extends GetxController {
  var isLoading = true.obs;
  var moviesListFinal = <Movie>[].obs;
  var moviesList = <Movie>[].obs;
  var moviesListFav = <Movie>[].obs;
  List<Categories> categoriesList = [
    Categories(
      image: "assets/action.svg",
      name: "Action",
    ),
    Categories(
      image: "assets/famille.svg",
      name: "Famille",
    ),
    Categories(
      image: "assets/drama.svg",
      name: "Drama",
    ),
    Categories(
      image: "assets/animation.svg",
      name: "Animation",
    ),
    Categories(
      image: "assets/aventure.svg",
      name: "Aventure",
    ),
  ];
  @override
  void onInit() {
    fetchMovies();
    super.onInit();
  }

  fetchMovies() async {
    try {
      isLoading(true);
      var movies = await RemoteServicesImplt().fetchMovies();
      if (movies != null) {
        moviesList.value = movies;
        moviesListFinal.value = movies;
      }
    } finally {
      isLoading(false);
    }
  }

  favorite(Movie movie) {
    if (movie.isFavorite.value) {
      moviesListFav.remove(movie);
    } else {
      moviesListFav.add(movie);
    }
    movie.isFavorite.toggle();
  }

  void runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      moviesList.value = moviesListFinal.value;
    } else {
      moviesList.value = moviesListFinal
          .where((movie) => movie.originalTitle
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
  }
}
