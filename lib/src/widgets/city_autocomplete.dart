import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:frontend_challenge_2/src/apis/google_places.dart';
import 'package:frontend_challenge_2/src/providers/weather.dart';
import 'package:provider/provider.dart';

class CityAutoComplete extends StatelessWidget {
  const CityAutoComplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weather, child) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: TypeAheadField(
            textFieldConfiguration: const TextFieldConfiguration(
              autofocus: true,
              decoration: InputDecoration(
                  labelText: 'Nova localização', border: OutlineInputBorder()),
            ),
            suggestionsCallback: _search,
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion as String),
              );
            },
            onSuggestionSelected: (suggestion) {
              weather.addCity(suggestion as String);
            },
          ),
        );
      },
    );
  }

  Future<List<String?>> _search(String text) async {
    var options = await GooglePlacesService.search(text);
    List<String> optionsText = options['predictions']
        .map((prediction) => prediction['description'])
        .toList()
        .cast<String>();
    return optionsText;
  }
}
