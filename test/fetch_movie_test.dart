
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mvc_movie_app/Model/movies.dart';
import 'package:mvc_movie_app/services/remote_service.dart';
import 'package:mvc_movie_app/utils/constantes.dart';

import 'fetch_movie_test.mocks.dart';



class RemoteServicesTest extends Mock implements RemoteServices{}
@GenerateMocks([RemoteServicesTest])
void main(){
group("fetch movies", (){
 late MockRemoteServicesTest remoteServicesTest;
    setUpAll(() {
      remoteServicesTest = MockRemoteServicesTest();
    });
    test('returns list Of Category if the Future completes successfully',
        () async {
      final model = <Movie>[];
      when(remoteServicesTest.fetchMovies()).thenAnswer((_) async {
        return model ;
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

});
}


