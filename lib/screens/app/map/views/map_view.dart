import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/screens/app/map/controller/map_controller.dart';
import 'package:medfest/screens/app/profile/controller/profile_controller.dart';
import 'package:medfest/utils/colors.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> with TickerProviderStateMixin {
  MapController mapController = Get.find<MapController>();
  late MapController mapControllerAccess;
  late ProfileController profileController;
  GoogleMapController? _mapController;
  final Set<Marker> markers = {}; //markers for google map
  late LatLng _center;
  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];
    double lat = double.tryParse(mapControllerAccess.lat.value)!;
    double lng = double.tryParse(mapControllerAccess.lng.value)!;

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyB-0otSV5tJJPu_KjrNT0Wc_zpblnpPjYQ",
      PointLatLng(mapControllerAccess.latitude.value,
          mapControllerAccess.longitude.value),
      PointLatLng(lat, lng),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      log(result.errorMessage.toString());
    }
    _addPolyLine(polylineCoordinates);
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");

    setState(() {
      Polyline polyline = Polyline(
        color: Colors.red,
        polylineId: id,
        points: polylineCoordinates,
        width: 4,
      );
      polylines[id] = polyline;
    });
  }

  // addMarkers() async {
  //   BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
  //     const ImageConfiguration(),
  //     "assets/png/orglogo.png",
  //   );
  //   mapControllerAccess.allOrganisationsData.toList().forEach((element) {
  //     List address = element.walletAddress.split(',');
  //     // var marker = Marker(
  //     //   markerId: MarkerId(address.toString()),
  //     //   position: LatLng(address[0], address[1]), //position of marker
  //     //   infoWindow: InfoWindow(
  //     //     //popup info
  //     //     title: element.orgType,
  //     //     snippet: 'Hold for more information',
  //     //   ),
  //     //   icon: markerbitmap, //Icon for Marker
  //     // );
  //     // markers.add(marker);
  //   });
  // }

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};

  void _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/json/map_style.json');
    _mapController?.setMapStyle(value);
    setState(() {});
  }

  @override
  void initState() {
    profileController = Get.find<ProfileController>();
    mapControllerAccess = Get.find<MapController>();
    _center =
        LatLng(mapController.latitude.value, mapController.longitude.value);

    //addMarkers();
    super.initState();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              compassEnabled: true,
              myLocationEnabled: true,
              trafficEnabled: true,
              markers: markers, //markers to show on map
              polylines: Set<Polyline>.of(polylines.values),
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 12.0,
              ),
            ),
            Positioned(
              top: 50.0,
              right: 15.0,
              left: 15.0,
              child: Column(
                children: [
                  Container(
                    height: 60.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(curveRadius),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1.0, 5.0),
                            blurRadius: 10,
                            spreadRadius: 3)
                      ],
                    ),
                    child: TextField(
                      onChanged: (value) =>
                          mapController.searchFirstPlaces(value),
                      cursorColor: Colors.black,
                      // controller: appState.mapController,
                      decoration: InputDecoration(
                        icon: Container(
                          margin: const EdgeInsets.only(left: 20, top: 5),
                          width: 10,
                          height: 10,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.black,
                          ),
                        ),
                        hintText: "Locate our facilities closest to you",
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.only(left: 15.0, top: 16.0),
                      ),
                    ),
                  ),
                  Obx(
                    () => (mapController.searchResults.isNotEmpty &&
                            mapController.searchResults != null)
                        ? Flexible(
                            child: ListView.builder(
                                itemCount: mapController.searchResults.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      mapController
                                          .searchResults[index].description,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    onTap: () async {
                                      await mapController.getCoordinate(
                                          mapController.searchResults[index]
                                              .description);

                                      _getPolyline();
                                    },
                                  );
                                }),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: size.height * 0.40,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: kWhiteColor.withOpacity(0.6),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(curveRadius),
                        topLeft: Radius.circular(curveRadius)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const CText(
                        text: "Registered Medical Facilities",
                        fontWeight: FontWeight.w400,
                        color: kBlackColor,
                        size: 18,
                      ),
                      Flexible(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount:
                              mapController.allOrganisationsData.value.length,
                          // itemCount: 6,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                log("hereeeeeeeeeeeeeeee");
                                log(mapController
                                    .allOrganisationsData[index].address);
                                List address = mapController
                                    .allOrganisationsData[index].address
                                    .split(',');
                                LatLng newlatlang = LatLng(
                                    double.parse(address[0]),
                                    double.parse(address[1]));
                                _mapController!.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                        target: newlatlang, zoom: 12),
                                  ),
                                );
                                markers.add(
                                  Marker(
                                    markerId: MarkerId(mapController
                                        .allOrganisationsData[index].address),
                                    position: LatLng(double.parse(address[0]),
                                        double.parse(address[1])),
                                    infoWindow: InfoWindow(
                                      title: mapController
                                          .allOrganisationsData[index].orgType,
                                    ),
                                  ),
                                );
                                log("done");
                                setState(() {});
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: SizedBox(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 70,
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                            color:
                                                kPrimaryColor.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(
                                                curveRadius)),
                                        child: const Center(
                                          child: Icon(
                                            Icons.location_on,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CText(
                                            text: mapController
                                                .allOrganisationsData[index]
                                                .fullName,
                                            fontWeight: FontWeight.w400,
                                            color: kBlackColor,
                                            size: 18,
                                          ),
                                          const SizedBox(height: 10),
                                          CText(
                                            text: mapController
                                                .allOrganisationsData[index]
                                                .orgType,
                                            fontWeight: FontWeight.w300,
                                            color: kDarkGreyColor,
                                            size: 13,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
