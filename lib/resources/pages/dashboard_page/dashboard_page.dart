import 'package:flutter/material.dart';
import 'package:flutter_app/bootstrap/extensions.dart';
import 'package:flutter_app/resources/pages/pages.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nylo_framework/nylo_framework.dart';

class DashboardPage extends NyStatefulWidget {
  static const path = '/dashboard';

  DashboardPage() : super(path, child: _DashboardPageState());
}

class _DashboardPageState extends NyState<DashboardPage> {
  int _currentIndex = 0;

  @override
  boot() async {
    if (!await Auth.loggedIn()) {
      routeTo(SignInPage.path);
      return;
    }
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _page,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('places.svg').localAsset(),
            activeIcon: SvgPicture.asset('places_active.svg').localAsset(),
            label: 'Подборки',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('profile.svg').localAsset(),
            activeIcon: SvgPicture.asset('profile_active.svg').localAsset(),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }

  StatefulWidget get _page => switch (_currentIndex) {
        0 => PlacesPage(),
        1 => ProfilePage(),
        _ => PlacesPage(),
      };
}
