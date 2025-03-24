class Utilisateur{
  final int idUtilisateur;
  final String dateAvis;
  final int idRestaurant;
  final String avis;
  final int note;

  const Utilisateur(this.idUtilisateur, this.dateAvis, this.idRestaurant, this.avis, this.note);

  Map<String,dynamic> toMap(){
    return {"idUtilisateur":idUtilisateur, "dateAvis":dateAvis, "idRestaurant":idRestaurant, "avis":avis, "note":note};
  }

  String toString(){
    return "Utilisateur: $idUtilisateur, Date de l'avis: $dateAvis, Avis: $avis, Note: $note";
  }
}