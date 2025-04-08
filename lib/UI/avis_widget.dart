import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sae_mobile/bd/avis_provider.dart';
import 'package:sae_mobile/bd/utilisateur_provider.dart';
import 'package:sae_mobile/model/avisutilisateur.dart';
import 'package:sae_mobile/model/restaurant.dart';
import 'package:sae_mobile/model/utilisateur.dart';

class AvisWidget extends StatefulWidget {
  final Restaurant restaurant;
  const AvisWidget({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<AvisWidget> createState() => _AvisWidgetState();
}

class _AvisWidgetState extends State<AvisWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _avisController = TextEditingController();
  int _note = 0;
  bool _showForm = false;

  Future<void> _showEditDialog(AvisUtilisateur avis) async {
    final editController = TextEditingController(text: avis.avis);
    int editNote = avis.note;

    showDialog(
      context: context,
      builder: (ctx) {
        final _editKey = GlobalKey<FormState>();
        return AlertDialog(
          title: const Text('Modifier mon avis'),
          content: SingleChildScrollView(
            child: Form(
              key: _editKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: editController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Votre avis',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Veuillez saisir un commentaire.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text('Note : '),
                      RatingBar.builder(
                        initialRating: editNote.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemSize: 30,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          editNote = rating.toInt();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (!_editKey.currentState!.validate()) return;
                if (editNote == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Veuillez sélectionner une note.')),
                  );
                  return;
                }
                final updatedAvis = AvisUtilisateur(
                  utilisateur: avis.utilisateur,
                  restaurant: avis.restaurant,
                  avis: editController.text.trim(),
                  note: editNote,
                  dateAvis: avis.dateAvis,
                );
                try {
                  await Provider.of<AvisProvider>(context, listen: false)
                      .updateAvisSupabase(updatedAvis);
                  Navigator.of(ctx).pop();
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Avis modifié avec succès !')),
                  );
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erreur : $error')),
                  );
                }
              },
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAvis(AvisUtilisateur avis) async {
    try {
      await Provider.of<AvisProvider>(context, listen: false).deleteAvisSupabase(
        avis.utilisateur.idUtilisateur,
        avis.dateAvis,
        avis.restaurant.id,
      );
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Avis supprimé avec succès !')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : $e')),
      );
    }
  }

  Future<void> _saveAvis() async {
    final user = Provider.of<UtilisateurProvider>(context, listen: false).utilisateur;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vous devez être connecté pour publier un avis.')),
      );
      return;
    }
    if (!_formKey.currentState!.validate()) return;
    if (_note == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez sélectionner une note.')),
      );
      return;
    }

    final newAvis = AvisUtilisateur(
      utilisateur: user,
      restaurant: widget.restaurant,
      avis: _avisController.text.trim(),
      note: _note,
      dateAvis: DateTime.now().toIso8601String(),
    );

    try {
      await Provider.of<AvisProvider>(context, listen: false)
          .insertAvisSupabase(newAvis);
      setState(() {
        _avisController.clear();
        _note = 0;
        _showForm = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Avis ajouté avec succès !')),
      );
    } catch (error) {
      final msg = error.toString();
      if (msg.contains('duplicate key') || msg.contains('violates unique constraint')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vous avez déjà rédigé un avis pour ce restaurant.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : $msg')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UtilisateurProvider>(context).utilisateur;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (user != null) ...[
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showForm = !_showForm;
              });
            },
            child: Text(_showForm ? 'Fermer le formulaire' : 'Donner mon avis'),
          ),
          const SizedBox(height: 10),
        ],

        // Formulaire d’ajout d’avis
        if (_showForm && user != null) ...[
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _avisController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Votre avis',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez saisir un commentaire.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text('Note : '),
                    RatingBar.builder(
                      initialRating: _note.toDouble(),
                      minRating: 1,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemSize: 30,
                      itemBuilder: (ctx, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() => _note = rating.toInt());
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: _saveAvis,
                    child: const Text('Publier mon avis'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],

        // Liste des avis
        FutureBuilder<List<AvisUtilisateur>>(
          future: Provider.of<AvisProvider>(context, listen: false)
              .getAvisByRestaurantId(widget.restaurant.id),
          builder: (ctx, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snap.hasError) {
              return Text('Erreur : ${snap.error}');
            } else if (!snap.hasData || snap.data!.isEmpty) {
              return const Text('Aucun avis pour le moment.');
            } else {
              final avisList = snap.data!;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: avisList.length,
                itemBuilder: (context, index) {
                  final avis = avisList[index];
                  final canEdit = user != null &&
                      (avis.utilisateur.idUtilisateur == user.idUtilisateur);

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(avis.avis),
                      subtitle: Text(
                        'Note : ${avis.note}\n'
                        'Par : ${avis.utilisateur.pseudo} le ${avis.dateAvis}',
                      ),
                      trailing: canEdit
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _showEditDialog(avis),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _deleteAvis(avis),
                                ),
                              ],
                            )
                          : null,
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
