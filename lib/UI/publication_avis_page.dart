import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sae_mobile/bd/avis_provider.dart';
import 'package:sae_mobile/bd/utilisateur_provider.dart';
import 'package:sae_mobile/model/avisutilisateur.dart';
import 'package:sae_mobile/model/restaurant.dart';
import 'package:sae_mobile/model/utilisateur.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PublicationAvisPage extends StatefulWidget {
  final Restaurant restaurant;

  const PublicationAvisPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  _PublicationAvisPageState createState() => _PublicationAvisPageState();
}

class _PublicationAvisPageState extends State<PublicationAvisPage> {
  final _formKey = GlobalKey<FormState>();
  final _avisController = TextEditingController();
  double _note = 0;

  final int currentUserId = 1;

  @override
  Widget build(BuildContext context) {
    final utilisateurProvider = Provider.of<UtilisateurProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Publier un avis"),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<Utilisateur>(
        future: utilisateurProvider.getUtilisateurFromIdSupabase(currentUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erreur: ${snapshot.error}"));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("Aucun utilisateur trouvé"));
          }
          final utilisateur = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("Laisser votre avis sur ${widget.restaurant.nomRestaurant}"),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _avisController,
                    decoration: const InputDecoration(
                      labelText: "Votre avis",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez entrer votre avis";
                      }
                      return null;
                    },
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      _note = rating;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final avis = AvisUtilisateur(
                          utilisateur: utilisateur,
                          restaurant: widget.restaurant,
                          avis: _avisController.text,
                          note: _note.toInt(),
                          dateAvis: DateTime.now().toIso8601String(),
                        );
                        Provider.of<AvisProvider>(context, listen: false)
                            .insertAvis(avis);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Avis publié avec succès")),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Publier"),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
