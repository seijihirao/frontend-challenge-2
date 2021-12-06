import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:frontend_challenge_2/src/apis/google_places.dart';
import 'package:frontend_challenge_2/src/widgets/city_autocomplete.dart';

class ScreenWeatherList extends StatelessWidget {
  const ScreenWeatherList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cities'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TypeAheadField(
                textFieldConfiguration: const TextFieldConfiguration(
                  autofocus: true,
                  decoration: InputDecoration(labelText: 'Search for a city'),
                ),
                suggestionsCallback: _search,
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion as String),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  print(suggestion);
                },
              ),
            ),
          ),
        ],
      ),
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
