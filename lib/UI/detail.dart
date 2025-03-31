import 'package:flutter/material.dart';
import 'package:sae_mobile/model/restaurant.dart';

class DetailPage extends StatelessWidget {
  final Restaurant restaurant;

  const DetailPage({super.key, required this.restaurant});

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
      backgroundColor: Colors.white60,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              restaurant.nomRestaurant,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Horaires :${restaurant.horaires}',
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
                Builder(
                  builder: (context) {
                    if (restaurant.vegan) {
                      return Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Propose des plats végan',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ]
                      );
                    } else {
                      return Row();
                    }
                  },
                ),
                Builder(
                  builder: (context) {
                    if (restaurant.vegetarien) {
                      return Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Propose des plats végétarien',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ]
                      );
                    } else {
                      return Row();
                    }
                  },
                ),
                Builder(
                  builder: (context) {
                    if (restaurant.accessInternet) {
                      return Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Accès à internet disponible',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ]
                      );
                    } else {
                      return Row();
                    }
                  },
                ),
                Builder(
                  builder: (context) {
                    if (restaurant.entreeFauteuilRoulant) {
                      return Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Entrée pour les fauteuils roulants disponible',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ]
                      );
                    } else {
                      return Row();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}