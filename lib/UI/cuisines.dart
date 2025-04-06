import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sae_mobile/bd/cuisine_provider.dart';
import 'package:sae_mobile/model/cuisine.dart';

import '../bd/utilisateur_provider.dart';
import '../model/utilisateur.dart';

class CuisinePage extends StatefulWidget {
  @override
  State<CuisinePage> createState() => _CuisinePageState();
}

class _CuisinePageState extends State<CuisinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Les cuisines disponibles'),
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
      body: FutureBuilder<List<Cuisine>>(
        future: context.watch<CuisineProvider>().getCuisinesSupabase(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Cuisine> lesCuisines = snapshot.data!;
            return ListView.builder(
              itemCount: lesCuisines.length,
              itemBuilder: (context, index) {
                return FutureBuilder<List<Cuisine>>(
                  future: Provider.of<CuisineProvider>(context, listen: false).getFavorisCuisine(Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!.idUtilisateur),
                  builder: (context, favSnapshot) {
                    if (favSnapshot.connectionState == ConnectionState.waiting) {
                      return ListTile(title: Text('Chargement...'));
                    }

                    bool isFavori = favSnapshot.data?.contains(lesCuisines[index]) ?? false;

                    return ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.restaurant, size: 40),
                          SizedBox(width: 20),
                        ],
                      ),
                      title: Text(lesCuisines[index].type),
                      trailing: IconButton(
                        icon: Icon(isFavori ? Icons.favorite : Icons.favorite_border),
                        tooltip: isFavori ? "Ajouter aux favoris" : "Retirer des favoris",
                        onPressed: () async {
                          Utilisateur? user = Provider.of<UtilisateurProvider>(context, listen: false).utilisateur;

                          if (user != null) {
                            if (isFavori) {
                              print("supprimer favoris");
                              Provider.of<CuisineProvider>(context, listen: false).supprimerFavorisCuisine(user.idUtilisateur, lesCuisines[index].id);
                            } else {
                              print("ajouter favoris");
                              Provider.of<CuisineProvider>(context, listen: false).ajouterFavorisCuisine(user.idUtilisateur, lesCuisines[index].id);
                            }
                            setState(() {});
                          }
                        },
                      ),
                    );
                  },
                );
              },
            );
          }

          return Center(child: Text('Aucune cuisine trouvée.'));
        },
      ),
    );
  }
}

