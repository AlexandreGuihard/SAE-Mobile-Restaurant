import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sae_mobile/model/restaurant.dart';
import 'package:sae_mobile/bd/restaurant_provider.dart';
import 'package:sae_mobile/model/utilisateur.dart';

import '../bd/utilisateur_provider.dart';

class DetailPage extends StatefulWidget {
  final Restaurant restaurant;

  const DetailPage({required this.restaurant});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String textBoutonFavoris = "";

  @override
  void initState() {
    super.initState();
    loadBoutonFavorisState();
  }

  Future<void> loadBoutonFavorisState() async {
    print("get utilisateur");
    Utilisateur? user = Provider.of<UtilisateurProvider>(context, listen: false).utilisateur;
    if (user != null) {
      List<Restaurant?> favoris = await Provider.of<RestaurantProvider>(context, listen: false).getFavorisRestaurant(user.idUtilisateur);
      setState(() {
        textBoutonFavoris = favoris.contains(widget.restaurant) ? "Retirer des favoris" : "Ajouter aux favoris";
      });
    } else {
      setState(() {
        textBoutonFavoris = "";
      });
    }
  }

  Future toggleBoutonFavoris() async {
    print("get utilisateur");
    Utilisateur? user = Provider.of<UtilisateurProvider>(context, listen: false).utilisateur;
    if (user != null) {
      List<Restaurant?> favoris = await Provider.of<RestaurantProvider>(context, listen: false).getFavorisRestaurant(user.idUtilisateur);

      bool isFavori = favoris.contains(widget.restaurant);

      if (isFavori) {
        print("supprimer favoris");
        Provider.of<RestaurantProvider>(context, listen: false).supprimerFavorisRestaurant(user.idUtilisateur, widget.restaurant.id);
      } else {
        print("ajouter favoris");
        Provider.of<RestaurantProvider>(context, listen: false).ajouterFavorisRestaurant(user.idUtilisateur, widget.restaurant.id);
      }

      // Mise à jour de l'interface après modification
      setState(() {
        textBoutonFavoris = isFavori ? "Ajouter aux favoris" : "Retirer des favoris";
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Détails du Restaurant'),
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
              widget.restaurant.nomRestaurant,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Horaires :${widget.restaurant.horaires}',
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
            Column(
              children: <Widget>[
                Builder(
                  builder: (context) {
                    if (widget.restaurant.vegan) {
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
                    if (widget.restaurant.vegetarien) {
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
                    if (widget.restaurant.accessInternet) {
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
                    if (widget.restaurant.entreeFauteuilRoulant) {
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
            if (context.watch<UtilisateurProvider>().utilisateur != null)
              ElevatedButton(
                onPressed: toggleBoutonFavoris,
                child: Text(textBoutonFavoris)),
          ],
        ),
      ),
    );
  }
}