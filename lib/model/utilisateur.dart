class Utilisateur{
  final int idUtilisateur;
  final String pseudo;
  final String motdepasse;
  final bool moderateur;

  const Utilisateur(this.idUtilisateur, this.pseudo, this.motdepasse, this.moderateur);

  Map<String,dynamic> toMap(){
    return {"idutilisateur":idUtilisateur, "pseudo":pseudo, "motdepasse":motdepasse, "moderateur":moderateur};
  }

  factory Utilisateur.fromMap(Map<String, dynamic> map) {
    return Utilisateur(
        map['idutilisateur'],
        map['pseudo'],
        map['motdepasse'],
        map['moderateur']
    );
  }

  String toString(){
    return "Utilisateur: $idUtilisateur, Pseudo: $pseudo, Moderateur: $moderateur";
  }
}