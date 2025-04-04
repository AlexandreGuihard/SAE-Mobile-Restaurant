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

  void insertAvisSupabase(AvisUtilisateur avis) async{
    await supabase.from("donner").insert(avis.toMap());
  }

  Future<AvisUtilisateur> getAvisFromPrimaryKeySupabase(int idUtilisateur, int idRestaurant, String dateAvis) async{
    final result=await supabase.from("donner").select().eq("idutilisateur", idUtilisateur).eq("idrestaurant", idRestaurant).eq("dateavis", dateAvis);
    Utilisateur utilisateur=utilisateurProvider.getUtilisateurFromIdSupabase(idUtilisateur);
    Restaurant restaurant=restaurantProvider.getRestaurantFromIdSupabase(idRestaurant);
    return AvisUtilisateur(utilisateur: utilisateur, restaurant: restaurant, avis: result["avis"], note: result["note"], dateAvis: result["dateavis"]);
  }

  Future<List<AvisUtilisateur>> getAvisSupabase() async{
    final result=await supabase.from("donner").select();
    List<AvisUtilisateur> lesAvis=[];
    for(var map in result){
      Utilisateur utilisateur=utilisateurProvider.getUtilisateurFromIdSupabase(map["idutilisateur"]);
      Restaurant restaurant=restaurantProvider.getRestaurantFromIdSupabase(map["idrestaurant"]);
      String avis=map["avis"];
      int note=map["note"];
      String dateAvis=map["dateavis"];
      var avisObject=AvisUtilisateur(utilisateur: utilisateur, restaurant: restaurant, avis: avis, note: note, dateAvis: dateAvis);
      lesAvis.add(avisObject);
    }
    return lesAvis;
  }

  void updateAvisSupabase(AvisUtilisateur avis) async{
    await supabase.from("donner").update(avis.toMap()).eq("idutilisateur", avis.utilisateur.idUtilisateur).eq("dateavis", avis.dateAvis).eq("idrestaurant", avis.restaurant.id);
  }

  void deleteAvisSupabase(int idUtilisateur, String dateAvis, int idRestaurant) async{
    await supabase.from("donner").delete().eq("idutilisateur", idUtilisateur).eq("dateavis", dateAvis).eq("idrestaurant", idRestaurant);
  }
}