import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GooglePlacesService {

  // Base URL used for requests
  static const String baseUrl = 'maps.googleapis.com';

  static Future<dynamic> search(String text) async {
    var params = {
      'input': text,
      'key': dotenv.env['GOOGLE_PLACES_API_KEY']
    };
    var response = await http.get(
      Uri.https(baseUrl, '/maps/api/place/autocomplete/json', params),
      headers: {
        'Accept': 'application/json'
      }
    );
    return json.decode(response.body);
  }
}