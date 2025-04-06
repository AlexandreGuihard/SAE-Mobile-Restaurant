import 'package:flutter/material.dart';
import 'package:sae_mobile/UI/cuisines.dart';
import 'package:sae_mobile/UI/home.dart';

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

        /// Messages page
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                ),
              ),
            );
          },
        ),
      ][_selectedIndex],
    );
  }
}