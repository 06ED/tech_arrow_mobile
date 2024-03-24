import 'package:flutter/material.dart';
import 'package:flutter_app/app/models/place.dart';
import 'package:flutter_app/config/storage_keys.dart';
import 'package:flutter_app/resources/pages/navbar_pages/places_page/widgets/item_widget.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../../../widgets/place_card.dart';

class PlaceTab extends StatefulWidget {
  final List<PlaceModel> places;
  final ScrollController scrollController;

  const PlaceTab({
    super.key,
    required this.places,
    required this.scrollController,
  });

  @override
  State<PlaceTab> createState() => _PlaceTabState();
}

class _PlaceTabState extends State<PlaceTab> {
  late var _filteredPlaces;

  double _minRatingPoint = 1.0;
  double _maxRatingPoint = 5.0;

  bool _eatCategory = true;
  bool _entertainmentCategory = true;
  bool _tourismCategory = true;

  final _searchController = TextEditingController();

  var _currentPage;
  bool _isAllPlaces = true;

  @override
  void initState() {
    _filteredPlaces = widget.places;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _filteredPlaces = widget.places
        .where((places) => places.title!
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
        .where((place) =>
            _minRatingPoint <= place.rating! &&
            place.rating! <= _maxRatingPoint)
        .where((place) => place.category == 1 ? _eatCategory : true)
        .where((place) => place.category == 2 ? _entertainmentCategory : true)
        .where((place) => place.category == 3 ? _tourismCategory : true)
        .toList();

    return _isAllPlaces ? _mainPage() : _currentPage;
  }

  Widget _selectedPage(PlaceModel place) => Flexible(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 179, 222, 255),
                Color.fromARGB(255, 88, 181, 255),
              ],
            ),
          ),
          child: CustomScrollView(
            controller: widget.scrollController,
            slivers: [
              SliverStickyHeader(
                header: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15)),
                    color: Color.fromARGB(200, 88, 181, 255),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          height: 7,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(102, 56, 56, 56),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () =>
                                setState(() => _isAllPlaces = true),
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: Color.fromARGB(255, 88, 181, 255),
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async =>
                                await NyStorage.addToCollection(
                              StorageKey.favoritePlaces,
                              item: place.id!,
                              allowDuplicates: false,
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Text(
                                    "Добавить в избранное",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            style: TextButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 88, 181, 255),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: BorderSide(
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) => Container(
                      margin: const EdgeInsets.all(10),
                      child: ItemWidget(
                        title: place.title!,
                        description: place.description!,
                        image: place.imagePath!,
                      ),
                    ),
                    childCount: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _mainPage() => Flexible(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 179, 222, 255),
                Color.fromARGB(255, 88, 181, 255),
              ],
            ),
          ),
          child: CustomScrollView(
            controller: widget.scrollController,
            slivers: [
              SliverStickyHeader(
                header: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15)),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          height: 7,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(102, 56, 56, 56),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: SearchBar(
                                controller: _searchController,
                                onChanged: (text) => setState(() {}),
                                constraints: BoxConstraints(minHeight: 40),
                                hintText: "Поиск",
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Color.fromRGBO(133, 197, 249, 1.0),
                                    width: 1.5,
                                  ),
                                ),
                                child: Center(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.view_headline_sharp,
                                      color: const Color(0xFF6EBFFF),
                                    ),
                                    onPressed: () =>
                                        filtersPoints(() => setState(() {})),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) => Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          for (int i = 0; i < _filteredPlaces.length; i++)
                            GestureDetector(
                              onTap: () => setState(() {
                                _currentPage =
                                    _selectedPage(_filteredPlaces[i]);
                                _isAllPlaces = false;
                              }),
                              child: PlaceCard(
                                title: _filteredPlaces[i].title!,
                                image: _filteredPlaces[i].image,
                                rating: _filteredPlaces[i].rating!,
                              ),
                            )
                        ],
                      ),
                    ),
                    childCount: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  void filtersPoints(VoidCallback onClose) {
    double _minRatinghelp = _minRatingPoint;
    double _maxRatinghelp = _maxRatingPoint;
    bool _eatCategoryhelp = _eatCategory;
    bool _entertainmentCategoryhelp = _entertainmentCategory;
    bool _tourismCategoryhelp = _tourismCategory;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back_outlined),
                  ),
                  Text("Фильтры точек"),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Оценка: от ${_minRatinghelp.toStringAsFixed(1)} до ${_maxRatinghelp.toStringAsFixed(1)}",
                  ),
                  RangeSlider(
                    values: RangeValues(_minRatinghelp, _maxRatinghelp),
                    min: 1.0,
                    max: 5.0,
                    divisions: 8,
                    labels: RangeLabels(
                      _minRatinghelp.toStringAsFixed(1),
                      _maxRatinghelp.toStringAsFixed(1),
                    ),
                    onChanged: (newRange) {
                      setState(() {
                        _minRatinghelp = newRange.start;
                        _maxRatinghelp = newRange.end;
                      });
                    },
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    "Категория",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _eatCategoryhelp,
                                onChanged: (value) {
                                  setState(() {
                                    _eatCategoryhelp = value!;
                                  });
                                },
                              ),
                              Text(
                                "Еда",
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: _entertainmentCategoryhelp,
                                onChanged: (value) {
                                  setState(() {
                                    _entertainmentCategoryhelp = value!;
                                  });
                                },
                              ),
                              Text(
                                "Развлечения",
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: _tourismCategoryhelp,
                            onChanged: (value) {
                              setState(() {
                                _tourismCategoryhelp = value!;
                              });
                            },
                          ),
                          Text(
                            "Туризм",
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    "Отмена",
                    style: TextStyle(color: Color(0xFF4086FA)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    "Сохранить",
                    style: TextStyle(color: Color(0xFF4086FA)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _minRatingPoint = _minRatinghelp;
                    _maxRatingPoint = _maxRatinghelp;
                    _eatCategory = _eatCategoryhelp;
                    _tourismCategory = _tourismCategoryhelp;
                    _entertainmentCategory = _entertainmentCategoryhelp;

                    onClose();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
