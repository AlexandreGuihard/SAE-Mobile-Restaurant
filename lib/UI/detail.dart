import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sae_mobile/bd/restaurant_provider.dart';
import 'package:sae_mobile/bd/utilisateur_provider.dart';
import 'package:sae_mobile/model/restaurant.dart';
import 'package:sae_mobile/UI/avis_widget.dart';

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
    _loadBoutonFavorisState();
  }

  Future<void> _loadBoutonFavorisState() async {
    final user =
        Provider.of<UtilisateurProvider>(context, listen: false).utilisateur;
    if (user == null) {
      setState(() => textBoutonFavoris = "");
      return;
    }
    final favoris =
        await Provider.of<RestaurantProvider>(context, listen: false)
            .getFavorisRestaurant(user.idUtilisateur);

    setState(() {
      textBoutonFavoris = favoris.contains(widget.restaurant)
          ? "Retirer des favoris"
          : "Ajouter aux favoris";
    });
  }

  Future<void> _toggleBoutonFavoris() async {
    final user =
        Provider.of<UtilisateurProvider>(context, listen: false).utilisateur;
    if (user == null) return;

    final favoris =
        await Provider.of<RestaurantProvider>(context, listen: false)
            .getFavorisRestaurant(user.idUtilisateur);

    final isFavori = favoris.contains(widget.restaurant);

    if (isFavori) {
      await Provider.of<RestaurantProvider>(context, listen: false)
          .supprimerFavorisRestaurant(user.idUtilisateur, widget.restaurant.id);
    } else {
      await Provider.of<RestaurantProvider>(context, listen: false)
          .ajouterFavorisRestaurant(user.idUtilisateur, widget.restaurant.id);
    }

    setState(() {
      textBoutonFavoris =
          isFavori ? "Ajouter aux favoris" : "Retirer des favoris";
    });
  }

  @override
  Widget build(BuildContext context) {
    final resto = widget.restaurant;
    final user = context.watch<UtilisateurProvider>().utilisateur;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du Restaurant'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              resto.nomRestaurant,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              'Horaires : ${resto.horaires}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),

            Center(
              child: Image.network(
                'images/exemple_restaurant.jpg',
                height: 200,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),

            if (resto.vegan)
              Row(
                children: const [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    'Propose des plats végan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            if (resto.vegetarien)
              Row(
                children: const [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    'Propose des plats végétariens',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            if (resto.accessInternet)
              Row(
                children: const [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    'Accès internet disponible',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            if (resto.entreeFauteuilRoulant)
              Row(
                children: const [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    'Entrée pour fauteuil roulant disponible',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),

            if (user != null && textBoutonFavoris.isNotEmpty)
              ElevatedButton(
                onPressed: _toggleBoutonFavoris,
                child: Text(textBoutonFavoris),
              ),

            const SizedBox(height: 20),
            AvisWidget(restaurant: resto),
          ],
        ),
      ),
    );
  }
}
