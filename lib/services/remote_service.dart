import 'package:http/http.dart' as http;
import 'package:mvc_movie_app/Model/movies.dart';
import 'package:mvc_movie_app/utils/constantes.dart';


abstract class RemoteServices{
  Future<List<Movie>?> fetchMovies();
}

class RemoteServicesImplt extends RemoteServices{
     var client = http.Client();


  @override
   Future<List<Movie>?> fetchMovies() async {
    var response = await client.get(Uri.parse(
        '${Constantes.baseUrl}/popular?api_key=e092f270dfe47d374283d758d90dbf88'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return Movies.fromJson(jsonString).movie;
    } else {
      return null;
    }
  }
}
