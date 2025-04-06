import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sae_mobile/bd/cuisine_provider.dart';
import 'package:sae_mobile/bd/restaurant_provider.dart';
import 'package:sae_mobile/model/cuisine.dart';
import 'package:sae_mobile/model/restaurant.dart';

import '../bd/utilisateur_provider.dart';
import '../model/utilisateur.dart';
import 'detail.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Utilisateur? user;
  late CuisineProvider cuisineProvider;
  late RestaurantProvider restaurantProvider;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UtilisateurProvider>(context, listen: false).utilisateur;
    cuisineProvider = Provider.of<CuisineProvider>(context, listen: false);
    restaurantProvider = Provider.of<RestaurantProvider>(context, listen: false);

    if (user == null) {
      Navigator.pushNamed(context, '/connection');
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Mon profile'),
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
          ],
        ),
        backgroundColor: Colors.white60,
        body: Center(
          child: Column(
            children: <Widget>[
              Text("Mes restaurants favoris"),
              Expanded(child: FutureBuilder(
                  future: restaurantProvider.getFavorisRestaurant(user!.idUtilisateur),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (!snapshot.hasData || snapshot.data == null) {
                      return Text("Aucun favori trouvé.");
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          List<Restaurant?>? restaurants = snapshot.data;

                          return ListTile(
                            leading: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.restaurant, size: 40),
                                const SizedBox(width: 20),
                                const CircleAvatar(
                                  backgroundImage:
                                  AssetImage('images/exemple_restaurant.jpg'),
                                  radius: 20,
                                ),
                              ],
                            ),
                            title: Text(restaurants![index]!.nomRestaurant),
                            subtitle: Text(
                                'Note: ${restaurants[index]?.nbEtoiles} ⭐'),
                            trailing: IconButton(
                              icon: Icon(Icons.favorite),
                              tooltip: "Retirer des favoris",
                              onPressed: () async {
                                if (user != null) {
                                  print("supprimer favoris");
                                  restaurantProvider.supprimerFavorisRestaurant(user!.idUtilisateur, restaurants[index]!.id);
                                  setState(() {});
                                }
                              },
                            ),
                            onTap: () {
                              print("Afficher détails");
                            },
                          );
                        }
                    );
                  }
                )
              ),
              Divider(),
              Text("Mes types de cuisine favoris"),
              Expanded(child: FutureBuilder(
                  future: cuisineProvider.getFavorisCuisine(user!.idUtilisateur),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (!snapshot.hasData || snapshot.data == null) {
                      return Text("Aucun favori trouvé.");
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          List<Cuisine?>? cuisines = snapshot.data;
                          return ListTile(
                            leading: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.restaurant, size: 40),
                                SizedBox(width: 20),
                              ],
                            ),
                            title: Text(cuisines![index]!.type),
                            trailing: IconButton(
                                icon: Icon(Icons.favorite),
                                tooltip: "Retirer des favoris",
                                onPressed: () async {
                                  print("supprimer favoris");
                                  Provider.of<CuisineProvider>(context, listen: false).supprimerFavorisCuisine(user!.idUtilisateur, cuisines[index]!.id);
                                  setState(() {});
                                }
                            ),
                          );
                        }
                    );
                  }
                )
              ),
            ],
          ),
        )
      );
    }
    return Center(child: Text("Pas connecté"),);
  }
}

