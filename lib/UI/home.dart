import 'package:flutter/material.dart';

class RestaurantsPage extends StatelessWidget {
  final List<String> restaurants = [
    'Le Gourmet',
    'Pizza Pasta',
    'Sushi Express',
    'Bistro Parisien',
    'Tacos Mania',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nos Restaurants'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Image.asset('images/logo.png'),
            tooltip: 'Accueil',
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ]
      ),
      backgroundColor: Colors.white60,
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              height: 80.0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.restaurant, size: 40),
                  SizedBox(width: 20),
                  CircleAvatar(
                    backgroundImage: AssetImage('images/exemple_restaurant.jpg'),
                    radius: 20,
                  ),
                ],
              ),
            ),
            title: Text(restaurants[index]),
            onTap: () {
              Navigator.pushNamed(context, '/detail');
            },
          );
        },
      ),
    );
  }
}
