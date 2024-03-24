import 'package:flutter/material.dart';
import 'package:flutter_app/app/controllers/home_controller.dart';
import 'package:flutter_app/app/models/route.dart';
import 'package:flutter_app/resources/pages/navbar_pages/places_page/tabs/place_tab.dart';
import 'package:flutter_app/resources/pages/navbar_pages/places_page/tabs/post_tab.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../app/models/place.dart';

class PlacesPage extends NyStatefulWidget<HomeController> {
  static const path = '/places';

  PlacesPage() : super(path, child: _PlacesPageState());
}

class _PlacesPageState extends NyState<PlacesPage> {
  double _sheetPosition = 0.2;

  int _currentIndex = 0;
  late List<RouteModel> routes;
  late List<PlaceModel> places;

  // Map values
  late YandexMapController _mapController;
  final _mapObjects = <MapObject>[];

  // Map points
  final Point _selfPositionPoint = Point(latitude: 54.79016744735153, longitude: 32.05074783879847);

  @override
  boot() async {
    routes = await widget.controller.getRoutes() ?? [];
    places = await widget.controller.getPlaces() ?? [];

    places.forEach((place) {
      _mapObjects.add(PlacemarkMapObject(
        mapId: MapObjectId("point-${place.id}"),
        point: Point(
          latitude: place.lat!,
          longitude: place.lon!,
        ),
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(
              getImageAsset("locations/place_location.png"),
            ),
            scale: 0.6,
          ),
        ),
      ));
    });
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: (controller) {
              _mapController = controller;
              _mapController.moveCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _selfPositionPoint,
                    zoom: 11,
                  ),
                ),
                animation: MapAnimation(duration: 4),
              );
            },
            mapObjects: _mapObjects,
          ),
          DraggableScrollableSheet(
            initialChildSize: _sheetPosition,
            minChildSize: 0.18,
            maxChildSize: 0.8,
            snap: true,
            builder: (BuildContext context, ScrollController scrollController) {
              return Column(
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => _currentIndex = 0),
                          child: Container(
                            width: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 186, 225, 255),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(5),
                            child: Text(
                              "Места",
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 112, 201),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => _currentIndex = 1),
                          child: Container(
                            width: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 186, 225, 255),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(5),
                            child: Text(
                              "Посты",
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 112, 201),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  NySwitch(
                    widgets: [
                      PlaceTab(
                          places: places, scrollController: scrollController),
                      PostTab(
                          posts: routes, scrollController: scrollController),
                    ],
                    indexSelected: _currentIndex,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
