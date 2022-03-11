import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:geocoder2/geocoder2.dart' as g2;

import 'package:location/location.dart';
import 'package:medfest/models/all_organisations.dart';
import 'package:medfest/models/places.dart';
import 'package:medfest/models/places_search.dart';
import 'package:medfest/services/api.dart';
import 'package:medfest/services/google_service.dart';

class MapController extends GetxController {
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  final box = GetStorage();
  List<AllOrganisations> allOrganisations = [];
  RxList<AllOrganisations> allOrganisationsData = <AllOrganisations>[].obs;

  RxList<PlaceSearch> searchResults = <PlaceSearch>[].obs;
  late String placeType;
  RxList<Place> placeResults = <Place>[].obs;
  final placesService = PlacesService();
  RxString lat = ''.obs;
  RxString lng = ''.obs;

  getAppOrganisations() async {
    try {
      log("getting all organizations");
      var url = "organizations";
      var response = await ApiService.getDataWithTokenTwo(url);
      log(response.toString());
      if (response is! String) {
        allOrganisations = allOrganisationsFromJson(response);
        allOrganisationsData.value = allOrganisations;
      } else {
        if (response.isNotEmpty) {
          allOrganisations = allOrganisationsFromJson(response);
          allOrganisationsData.value = allOrganisations;
          log(allOrganisationsData.value.length.toString());
        }
        log(" all organizations response is ${response.toString()}");
        // cToast(msg: response.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  searchFirstPlaces(String searchTerm) async {
    List<PlaceSearch> searchResult =
        await placesService.getAutocomplete(searchTerm);
    searchResults.value = List.from(searchResult);
  }

  Future<bool> getCoordinate(String placeDescription) async {
    final query = placeDescription;
    // var addresses = await Geocoder.local.findAddressesFromQuery(query);
    // var first = addresses.first;
    // log("coordinates ${first.coordinates}");
    // List coordinates = first.coordinates.toString().split(',');

    

    g2.GeoData fetchGeocoder =
        await g2.Geocoder2.getDataFromAddress(            
            address: query,
            googleMapApiKey: 'AIzaSyDaq4-qXR8iOA7jrESp_TUSauJtOdR7Zso');
    // var first = fetchGeocoder.result.first

    // lat.value = "${first.geometry.location.lat}";
    // lng.value = "${first.geometry.location.lng}";

    //fieldOne.text = placeDescription;
    searchResults.value = [];
    return true;

    //create polyline
  }

  _getCurrentLocation() async {
    Location location = Location();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      // Check if permission is granted
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final _locationData = await location.getLocation();
    latitude.value = _locationData.latitude!;
    longitude.value = _locationData.longitude!;
    box.write("lat", _locationData.latitude);
    box.write("lng", _locationData.longitude);
  }

  @override
  void onReady() {
    _getCurrentLocation();
    getAppOrganisations();
    super.onReady();
  }
}
