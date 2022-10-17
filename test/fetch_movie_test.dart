import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mvc_movie_app/Model/movies.dart';
import 'package:mvc_movie_app/controller/movies_controller.dart';
import 'package:mvc_movie_app/services/remote_service.dart';
import 'package:mvc_movie_app/utils/constantes.dart';

import 'fetch_movie_test.mocks.dart';

class RemoteServicesTest extends Mock implements RemoteServices {}

@GenerateMocks([RemoteServicesTest])
void main() {
  group("fetch movies", () {
    late MockRemoteServicesTest remoteServicesTest;
    late MoviesController moviesController;
    setUpAll(() {
      remoteServicesTest = MockRemoteServicesTest();
      moviesController = MoviesController();
    });
    test('returns list Of Category if the Future completes successfully',
        () async {
      final model = <Movie>[];
      when(remoteServicesTest.fetchMovies()).thenAnswer((_) async {
        return model;
      });
      final res = await remoteServicesTest.fetchMovies();
      expect(res, isA<List<Movie>>());
      expect(res, model);
    });

    test("test fetch movies throws null", () async {
      when(remoteServicesTest.fetchMovies()).thenAnswer((_) async {
        return null;
      });
      final res = await remoteServicesTest.fetchMovies();
      expect(res, null);
    });

    test("test fetch movie function ", () async {
      expect(moviesController.isLoading.value,true);
      await moviesController.fetchMovies();
      expect(moviesController.isLoading.value,false);
    });

    test("test favorite function", () async {
// fetch list movies
      await moviesController.fetchMovies();
// add first movie to favorite list
      moviesController.favorite(moviesController.moviesList[0]);
//check if movie added to favorite list
      expect(moviesController.moviesListFav,
          <Movie>[moviesController.moviesList[0]]);
// add second movie to favorite list
      moviesController.favorite(moviesController.moviesList[1]);
//check if movie added to favorite list
      expect(moviesController.moviesListFav, <Movie>[
        moviesController.moviesList[0],
        moviesController.moviesList[1]
      ]);
// remove first movie from favorite list
      moviesController.favorite(moviesController.moviesList[0]);
//check if movie removed from favorite list
      expect(moviesController.moviesListFav,
          <Movie>[moviesController.moviesList[1]]);
// remove second movie from favorite list
      moviesController.favorite(moviesController.moviesList[1]);
//check if movie removed from favorite list
      expect(moviesController.moviesListFav, <Movie>[]);
    });

    test("test filter function", () async {
      // fetch list movies
      await moviesController.fetchMovies();
      //Tap  text Bullet Train
      moviesController.runFilter("Bullet Train");
      //Expect one movie in the moviesList with title Bullet Train
      expect(moviesController.moviesList.single.originalTitle, "Bullet Train");

      //Tap Text the
      moviesController.runFilter("the");

      //check if 4 movies contain the in their title
      expect(moviesController.moviesList.length, 4);
    });
  });
}
