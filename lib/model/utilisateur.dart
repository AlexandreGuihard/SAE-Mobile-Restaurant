class Utilisateur{
  final int idUtilisateur;
  final String pseudo;
  final bool moderateur;

  const Utilisateur(this.idUtilisateur, this.pseudo, this.moderateur);

  Map<String,dynamic> toMap(){
    return {"idutilisateur":idUtilisateur, "pseudo":pseudo, "moderateur":moderateur};
  }

  factory Utilisateur.fromMap(Map<String, dynamic> map) {
    return Utilisateur(
        map['idutilisateur'],
        map['pseudo'],
        map['moderateur']
    );
  }

  String toString(){
    return "Utilisateur: $idUtilisateur, Pseudo: $pseudo, Moderateur: $moderateur";
  }
}