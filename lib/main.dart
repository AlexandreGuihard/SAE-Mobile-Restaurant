import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurants',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => RestaurantsPage(),
        '/secondPage': (context) => DetailPage(),
      },
      initialRoute: '/'
    );
  }
}

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
        title: Text('Restaurants'),
      ),
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
              Navigator.pushNamed(context, '/secondPage');
            },
          );
        },
      ),
    );
  }
}


class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Restaurant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Le Petit Vegan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Horaires :\nLundi - Vendredi: 12h00 - 22h00\nSamedi - Dimanche: 10h00 - 23h00',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Center(
              child: Image.network(
                'images/exemple_restaurant.jpg',
                height: 200,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                SizedBox(width: 8),
                Text(
                  'Restaurant 100% Végan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
