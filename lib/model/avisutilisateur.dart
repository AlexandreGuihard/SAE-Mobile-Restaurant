import 'package:sae_mobile/model/restaurant.dart';
import 'package:sae_mobile/model/utilisateur.dart';

class AvisUtilisateur{
  final Utilisateur utilisateur;
  final Restaurant restaurant;
  final String avis;
  final int note;
  final String dateAvis;

  const AvisUtilisateur({required this.utilisateur, required this.restaurant, required this.avis, required this.note, required this.dateAvis});

  factory AvisUtilisateur.fromMap(Map<String, dynamic> map){
    return AvisUtilisateur(utilisateur: map["utilisateur"], restaurant: map["restaurant"], avis: map["avis"], note: map["note"], dateAvis: map["dateAvis"]);
  }

  Map<String, dynamic> toMap(){
    return {"idutilisateur":utilisateur.idUtilisateur, "dateavis":dateAvis, "idrestaurant":restaurant.id, "avis":avis, "note":note};
  }
}