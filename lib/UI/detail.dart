import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Détail du Restaurant'),
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