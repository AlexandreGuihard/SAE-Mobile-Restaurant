import 'package:flutter/material.dart';
import 'package:sae_mobile/UI/cuisines.dart';
import 'package:sae_mobile/UI/home.dart';
import 'package:sae_mobile/UI/profile.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<AppNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        indicatorColor: Colors.green,
        selectedIndex: _selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.restaurant),
            label: 'Restaurants',
          ),
          NavigationDestination(
            icon: Icon(Icons.kitchen),
            label: 'Cuisines',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Mon profile',
          ),
        ],
      ),
      body:
      <Widget>[
        /// Restaurants page
        RestaurantsPage(),

        /// Cuisines page
        CuisinePage(),

        /// Profile page
        ProfilePage(),
      ][_selectedIndex],
    );
  }
}