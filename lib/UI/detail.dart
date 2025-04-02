import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sae_mobile/model/restaurant.dart';
import 'package:sae_mobile/model/utilisateur.dart';
import 'package:sae_mobile/model/avisutilisateur.dart';
import 'package:sae_mobile/bd/avis_provider.dart';
import '../bd/utilisateur_provider.dart';
import 'publication_avis_page.dart';

class DetailPage extends StatelessWidget {
  final Restaurant restaurant;

  const DetailPage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final utilisateurProvider = Provider.of<UtilisateurProvider>(context, listen: false);

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              restaurant.nomRestaurant,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Horaires : ${restaurant.horaires}',
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
            Column(
              children: <Widget>[
                Builder(
                  builder: (context) {
                    if (restaurant.vegan) {
                      return Row(
                        children: const [
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
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                Builder(
                  builder: (context) {
                    if (restaurant.vegetarien) {
                      return Row(
                        children: const [
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
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                Builder(
                  builder: (context) {
                    if (restaurant.accessInternet) {
                      return Row(
                        children: const [
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
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                Builder(
                  builder: (context) {
                    if (restaurant.entreeFauteuilRoulant) {
                      return Row(
                        children: const [
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
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                const Divider(thickness: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Avis",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    if (utilisateurProvider != null)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PublicationAvisPage(restaurant: restaurant),
                            ),
                          );
                        },
                        child: const Text("Publier un avis"),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                FutureBuilder<List<AvisUtilisateur>>(
                  future: Provider.of<AvisProvider>(context, listen: false).getAvisSupabase(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text("Erreur: ${snapshot.error}"));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text("Aucun avis pour ce restaurant.");
                    }
                    // Filtrer les avis pour n'afficher que ceux du restaurant courant
                    List<AvisUtilisateur> avisForRestaurant = snapshot.data!
                        .where((avis) => avis.restaurant.id == restaurant.id)
                        .toList();
                    if (avisForRestaurant.isEmpty) {
                      return const Text("Aucun avis pour ce restaurant.");
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: avisForRestaurant.length,
                      itemBuilder: (context, index) {
                        final avis = avisForRestaurant[index];
                        return ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(avis.utilisateur.pseudo),
                          subtitle: Text(avis.avis),
                          trailing: Text(avis.note.toString()),
                        );
                      },
                    );
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
