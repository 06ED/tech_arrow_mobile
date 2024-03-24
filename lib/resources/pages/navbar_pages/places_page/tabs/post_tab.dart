import 'package:flutter/material.dart';
import 'package:flutter_app/app/models/route.dart';
import 'package:flutter_app/resources/pages/navbar_pages/places_page/widgets/item_widget.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../../../../config/storage_keys.dart';
import '../../../../widgets/route_card.dart';

class PostTab extends StatefulWidget {
  final List<RouteModel> posts;
  final ScrollController scrollController;

  const PostTab({
    super.key,
    required this.posts,
    required this.scrollController,
  });

  @override
  State<PostTab> createState() => _PostTabState();
}

class _PostTabState extends State<PostTab> {
  late var _filteredPosts;

  double _minRatingRoutes = 1.0;
  double _maxRatingRoutes = 5.0;

  double _minDuration = 15.0;
  double _maxDuration = 120.0;

  bool _eatCategory = true;
  bool _entertainmentCategory = true;
  bool _tourismCategory = true;

  bool _isAllTab = true;
  var _currentPage;

  final _searchController = TextEditingController();

  @override
  void initState() {
    _filteredPosts = widget.posts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _filteredPosts = widget.posts
        .where((post) => post.title!
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
        .where((post) =>
            _minRatingRoutes <= post.rating! &&
            post.rating! <= _maxRatingRoutes)
        .where((post) =>
            _minDuration <= post.duration! && post.duration! <= _maxDuration)
        .where((post) => post.category == 1 ? _eatCategory : true)
        .where((post) => post.category == 2 ? _entertainmentCategory : true)
        .where((post) => post.category == 3 ? _tourismCategory : true)
        .toList();
    return _isAllTab ? _mainPage() : _currentPage;
  }

  Widget _selectedPage(RouteModel post) => Flexible(
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
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => setState(() => _isAllTab = true),
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
                              StorageKey.favoritePosts,
                              item: post.id!,
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
                              ),
                            ),
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
                        title: post.title!,
                        description: post.description!,
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
                                        filterPosts(() => setState(() {})),
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
                          for (int i = 0; i < _filteredPosts.length; i++)
                            GestureDetector(
                              onTap: () => setState(() {
                                _currentPage = _selectedPage(_filteredPosts[i]);
                                _isAllTab = false;
                              }),
                              child: RouteCard(
                                title: _filteredPosts[i].title!,
                                description: _filteredPosts[i].description!,
                                rating: _filteredPosts[i].rating!,
                                time: _filteredPosts[i].duration!,
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

  void filterPosts(VoidCallback onTap) {
    double _minRatingRoutesHelp = _minRatingRoutes;
    double _maxRatingRoutesHelp = _maxRatingRoutes;
    double _minDurationHelp = _minDuration;
    double _maxDurationHelp = _maxDuration;

    bool _eatCategoryHelp = _eatCategory;
    bool _entertainmentCategoryHelp = _entertainmentCategory;
    bool _tourismCategoryHelp = _tourismCategory;

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
                  Text("Фильтры маршрутов"),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                      "Оценка: от ${_minRatingRoutesHelp.toStringAsFixed(1)} до ${_maxRatingRoutesHelp.toStringAsFixed(1)}"),
                  RangeSlider(
                    values:
                        RangeValues(_minRatingRoutesHelp, _maxRatingRoutesHelp),
                    min: 1.0,
                    max: 5.0,
                    divisions: 8,
                    labels: RangeLabels(
                      _minRatingRoutesHelp.toStringAsFixed(1),
                      _maxRatingRoutesHelp.toStringAsFixed(1),
                    ),
                    onChanged: (newRange) {
                      setState(() {
                        _minRatingRoutesHelp = newRange.start;
                        _maxRatingRoutesHelp = newRange.end;
                      });
                    },
                  ),
                  SizedBox(height: 30.0),
                  Text(
                      "Длительность: от ${_minDurationHelp.toInt()} до ${_maxDurationHelp.toInt()} минут"),
                  RangeSlider(
                    values: RangeValues(_minDurationHelp, _maxDurationHelp),
                    min: 10.0,
                    max: 120.0,
                    divisions: 11,
                    labels: RangeLabels(
                      _minDurationHelp.toInt().toString(),
                      _maxDurationHelp.toInt().toString(),
                    ),
                    onChanged: (newRange) {
                      setState(() {
                        _minDurationHelp = newRange.start;
                        _maxDurationHelp = newRange.end;
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
                                value: _eatCategoryHelp,
                                onChanged: (value) {
                                  setState(() {
                                    _eatCategoryHelp = value!;
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
                                value: _entertainmentCategoryHelp,
                                onChanged: (value) {
                                  setState(() {
                                    _entertainmentCategoryHelp = value!;
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
                            value: _tourismCategoryHelp,
                            onChanged: (value) =>
                                setState(() => _tourismCategoryHelp = value!),
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

                    _maxRatingRoutes = _maxRatingRoutesHelp;
                    _minRatingRoutes = _minRatingRoutesHelp;
                    _maxDuration = _maxDurationHelp;
                    _minDuration = _minDurationHelp;
                    _eatCategory = _eatCategoryHelp;
                    _tourismCategory = _tourismCategoryHelp;
                    _eatCategory = _entertainmentCategoryHelp;

                    onTap();
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
