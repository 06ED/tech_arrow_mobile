import 'package:flutter/material.dart';
import 'package:flutter_app/app/controllers/favorite_controller.dart';
import 'package:flutter_app/resources/pages/navbar_pages/profile_page/tabs/favorite_places_tab.dart';
import 'package:flutter_app/resources/pages/navbar_pages/profile_page/tabs/favorite_posts_tab.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../../../app/models/place.dart';
import '../../../../app/models/route.dart';
import '../../../../app/models/user.dart';

class ProfilePage extends NyStatefulWidget<FavoriteController> {
  static const path = '/profile';

  ProfilePage() : super(path, child: _ProfilePageState());
}

class _ProfilePageState extends NyState<ProfilePage> {
  int _currentIndex = 0;

  late List<RouteModel> posts;
  late List<PlaceModel> places;

  @override
  boot() async {
    posts = await widget.controller.getFavoritePosts();
    places = await widget.controller.getFavoritePlaces();
  }

  @override
  Widget view(BuildContext context) {
    final user = Auth.user<User>();
    return afterLoad(
      child: () => Scaffold(
        appBar: AppBar(
          title: Text('Ваш профиль'),
          backgroundColor: Color.fromARGB(255, 88, 181, 255),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 20.0),
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 88, 181, 255),
                  radius: 50.0,
                  backgroundImage: AssetImage('public/assets/images/image.png'),
                ),
                SizedBox(width: 20.0),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    user!.email!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFEFF8FF),
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: Color.fromARGB(255, 150, 210, 255),
                  ), // Обводка сверху и снизу
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Icon(
                      Icons.bookmark_outline,
                      color: Color.fromARGB(255, 0, 112, 201),
                    ),
                    SizedBox(width: 5),
                    _buildScrollableItem('Места', 0),
                    _buildScrollableItem('Посты', 1),
                    _buildDivider(),
                    _buildScrollableItem('Отзывы', 2),
                    _buildScrollableItem('Фото', 3),
                    _buildScrollableItem('Комментарии', 4),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            NySwitch(
              indexSelected: _currentIndex,
              widgets: [
                FavoritePlacesTab(places: places),
                FavoritePostsTab(routes: posts),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollableItem(String text, int index) {
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        margin: EdgeInsets.only(right: 10),
        child: Text(
          text,
          style: TextStyle(
            color: Color.fromARGB(255, 0, 112, 201),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.grey,
      margin: EdgeInsets.symmetric(horizontal: 10),
    );
  }
}
