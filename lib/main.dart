import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mvc_movie_app/View/home_page.dart';
import 'package:mvc_movie_app/utils/colors.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';

void main() {
  runApp(GetMaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.dark(
        primary: HexColor.fromHex("#FB0000"),
      ),
    ),
    title: 'Movie_App',
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

/*class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _startPointController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter MapBox AutoComplete example"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: CustomTextField(
          hintText: "Select starting point",
          textController: _startPointController,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapBoxAutoCompleteWidget(
                  apiKey:
                      "pk.eyJ1IjoiYWhtZWRqOTIiLCJhIjoiY2w0d2g0ZDN2MHJiZDNocWV5cHN1MWpieiJ9.Jpf-X1Tn7-VSms9mB05K8w",
                  hint: "Select starting point",
                  country: "TN",
                  limit: 10,
                  onSelect: (place) {
                    _startPointController.text = place.placeName!;
                  },
                ),
              ),
            );
          },
          enabled: true,
        ),
      ),
    );
  }
}*/
