import 'package:flutter/foundation.dart';
import 'package:sae_mobile/model/avisutilisateur.dart';
import 'package:sae_mobile/model/restaurant.dart';
import 'package:sae_mobile/model/utilisateur.dart';
import 'package:sae_mobile/bd/utilisateur_provider.dart';
import 'package:sae_mobile/bd/restaurant_provider.dart';

class AvisProvider extends ChangeNotifier {
  final db;
  final supabase;
  final UtilisateurProvider utilisateurProvider;
  final RestaurantProvider restaurantProvider;

  AvisProvider({
    required this.db,
    required this.supabase,
    required this.utilisateurProvider,
    required this.restaurantProvider,
  });

  AvisProvider.supabaseOnly({
    required this.supabase,
    required this.utilisateurProvider,
    required this.restaurantProvider,
  }) : db = null;

  Future<void> insertAvisSupabase(AvisUtilisateur avis) async {
    await supabase.from("donner").insert(avis.toMap());
  }

  Future<AvisUtilisateur?> getAvisFromPrimaryKeySupabase(
      int idUtilisateur, int idRestaurant, String dateAvis) async {
    final List<dynamic> result = await supabase.from("donner").select().eq("idutilisateur", idUtilisateur).eq("idrestaurant", idRestaurant).eq("dateavis", dateAvis);

    if (result.isEmpty) {
      return null;
    }
    final row = result.first as Map<String, dynamic>;

    final user = await utilisateurProvider.getUtilisateurFromIdSupabase(idUtilisateur);
    if (user == null) {
      return null;
    }

    final resto = await restaurantProvider.getRestaurantFromIdSupabase(idRestaurant);
    if (resto == null) {
      return null;
    }

    return AvisUtilisateur(
      utilisateur: user,
      restaurant: resto,
      avis: row["avis"],
      note: row["note"],
      dateAvis: row["dateavis"],
    );
  }

  Future<List<AvisUtilisateur>> getAvisSupabase() async {
    final List<dynamic> result = await supabase.from("donner").select();
    List<AvisUtilisateur> lesAvis = [];

    for (var e in result) {
      final map = e as Map<String, dynamic>;

      final user =  await utilisateurProvider.getUtilisateurFromIdSupabase(map["idutilisateur"]);
      final resto =  await restaurantProvider.getRestaurantFromIdSupabase(map["idrestaurant"]);


      if (user != null && resto != null) {
        lesAvis.add(
          AvisUtilisateur(
            utilisateur: user,
            restaurant: resto,
            avis: map["avis"],
            note: map["note"],
            dateAvis: map["dateavis"],
          ),
        );
      }
    }

    return lesAvis;
  }

  Future<List<AvisUtilisateur>> getAvisByRestaurantId(int idRestaurant) async {
    final List<dynamic> result = await supabase.from("donner").select().eq("idrestaurant", idRestaurant);

    List<AvisUtilisateur> avisList = [];
    for (var e in result) {
      final map = e as Map<String, dynamic>;

      final user =  await utilisateurProvider.getUtilisateurFromIdSupabase(map["idutilisateur"]);
      final resto =  await restaurantProvider.getRestaurantFromIdSupabase(map["idrestaurant"]);

      if (user != null && resto != null) {
        avisList.add(
          AvisUtilisateur(
            utilisateur: user,
            restaurant: resto,
            avis: map["avis"],
            note: map["note"],
            dateAvis: map["dateavis"],
          ),
        );
      }
    }
    return avisList;
  }

  Future<void> updateAvisSupabase(AvisUtilisateur avis) async {
    await supabase.from("donner").update(avis.toMap()).eq("idutilisateur", avis.utilisateur.idUtilisateur).eq("idrestaurant", avis.restaurant.id).eq("dateavis", avis.dateAvis);
  }

  Future<void> deleteAvisSupabase(
      int idUtilisateur, String dateAvis, int idRestaurant) async {
    await supabase.from("donner").delete().eq("idutilisateur", idUtilisateur).eq("idrestaurant", idRestaurant).eq("dateavis", dateAvis);
  }
}
