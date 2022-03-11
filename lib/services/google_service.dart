import 'dart:developer';

import 'package:google_api_headers/google_api_headers.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:medfest/models/places.dart';
import 'package:medfest/models/places_search.dart';





class PlacesService {
  final key = 'AIzaSyDaq4-qXR8iOA7jrESp_TUSauJtOdR7Zso';

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    var urlString =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&key=$key';
    var url = Uri.parse(urlString);
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    log(json.toString());
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  Future<Place> getPlace(String placeId) async {
    var urlString =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    var url = Uri.parse(urlString);
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    log(json);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResult);
  }

  Future<List<Place>> getPlaces(
      double lat, double lng, String placeType) async {
    var urlString =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?location=$lat,$lng&type=$placeType&rankby=distance&key=$key';
    var url = Uri.parse(urlString);
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}
