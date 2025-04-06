import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sae_mobile/bd/avis_provider.dart';
import 'package:sae_mobile/bd/utilisateur_provider.dart';
import 'package:sae_mobile/model/restaurant.dart';
import 'package:sae_mobile/model/utilisateur.dart';
import 'package:sae_mobile/model/avisutilisateur.dart';

class AvisFormDialog extends StatefulWidget {
  final Restaurant restaurant;
  final VoidCallback? onSubmit;

  const AvisFormDialog({
    Key? key,
    required this.restaurant,
    this.onSubmit,
  }) : super(key: key);

  @override
  State<AvisFormDialog> createState() => _AvisFormDialogState();
}

class _AvisFormDialogState extends State<AvisFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _avisController = TextEditingController();
  int _note = 0;

  @override
  void dispose() {
    _avisController.dispose();
    super.dispose();
  }

  Future<void> _saveAvis() async {
    final user = Provider.of<UtilisateurProvider>(context, listen: false).utilisateur;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vous devez être connecté.')),
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
      await Provider.of<AvisProvider>(context, listen: false).insertAvisSupabase(newAvis);
      widget.onSubmit?.call();
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
    return Form(
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
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 30,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _note = rating.toInt();
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _saveAvis,
            child: const Text('Publier mon avis'),
          ),
        ],
      ),
    );
  }
}
