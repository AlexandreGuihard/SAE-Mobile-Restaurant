import 'package:flutter/foundation.dart';
import 'package:sae_mobile/model/avisutilisateur.dart';
import 'package:sae_mobile/model/restaurant.dart';
import 'package:sae_mobile/model/utilisateur.dart';

class AvisProvider extends ChangeNotifier{
  final db;
  final supabase;
  final utilisateurProvider;
  final restaurantProvider;

  AvisProvider({required this.db, required this.supabase, required this.utilisateurProvider, required this.restaurantProvider});

  void insertAvis(AvisUtilisateur avis) async {
    await db.insert("DONNER", avis.toMap());
    print("Avis inséré : ${avis.toMap()}");
    notifyListeners();
  }

  Future<AvisUtilisateur> getAvisFromPrimaryKeySupabase(int idUtilisateur, int idRestaurant, String dateAvis) async{
    final result=await supabase.from("donner").select().eq("idutilisateur", idUtilisateur).eq("idrestaurant", idRestaurant).eq("dateavis", dateAvis);
    Utilisateur utilisateur=utilisateurProvider.getUtilisateurFromIdSupabase(idUtilisateur);
    Restaurant restaurant=restaurantProvider.getRestaurantFromIdSupabase(idRestaurant);
    return AvisUtilisateur(utilisateur: utilisateur, restaurant: restaurant, avis: result["avis"], note: result["note"], dateAvis: result["dateavis"]);
  }

  Future<List<AvisUtilisateur>> getAvisSupabase() async {
    final result = await supabase.from("donner").select();
    List<AvisUtilisateur> lesAvis = [];
    for (var map in result) {
      Utilisateur utilisateur = await utilisateurProvider.getUtilisateurFromIdSupabase(map["idutilisateur"]);
      Restaurant restaurant = await restaurantProvider.getRestaurantFromIdSupabase(map["idrestaurant"]);
      String avis = map["avis"];
      int note = map["note"];
      String dateAvis = map["dateavis"];
      var avisObject = AvisUtilisateur(
        utilisateur: utilisateur,
        restaurant: restaurant,
        avis: avis,
        note: note,
        dateAvis: dateAvis,
      );
      lesAvis.add(avisObject);
    }
    return lesAvis;
  }
}