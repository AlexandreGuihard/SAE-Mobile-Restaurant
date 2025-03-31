class Restaurant {
  int id;
  int idType;
  String nomRestaurant;
  String horaires;
  String siret;
  String numTel;
  String urlWeb;
  String commune;
  bool vegetarien;
  bool vegan;
  bool entreeFauteuilRoulant;
  bool accessInternet;
  String marque;
  int nbEtoiles;
  String urlFacebook;

  Restaurant({
    required this.id,
    required this.idType,
    required this.nomRestaurant,
    required this.horaires,
    required this.siret,
    required this.numTel,
    required this.urlWeb,
    required this.commune,
    required this.vegetarien,
    required this.vegan,
    required this.entreeFauteuilRoulant,
    required this.accessInternet,
    required this.marque,
    required this.nbEtoiles,
    required this.urlFacebook,
  });

  Map<String, dynamic> toMap() {
    return {
      'idRestaurant': id,
      'idType': idType,
      'nomRestaurant': nomRestaurant,
      'horaires': horaires,
      'siret': siret,
      'numTel': numTel,
      'urlWeb': urlWeb,
      'commune': commune,
      'vegetarien': vegetarien,
      'vegan': vegan,
      'entreeFauteuilRoulant': entreeFauteuilRoulant,
      'accessInternet': accessInternet,
      'marque': marque,
      'nbEtoiles': nbEtoiles,
      'urlFacebook': urlFacebook
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['idRestaurant'],
      idType: map['idType'],
      nomRestaurant: map['nomRestaurant'],
      horaires: map['horaires'],
      siret: map['siret'],
      numTel: map['numTel'],
      urlWeb: map['urlWeb'],
      commune: map['commune'],
      vegetarien: map['vegetarien'],
      vegan: map['vegan'],
      entreeFauteuilRoulant: map['entreeFauteuilRoulant'],
      accessInternet: map['accessInternet'],
      marque: map['marqueRestaurant'],
      nbEtoiles: map['nbEtoiles'],
      urlFacebook: map['urlFacebook'],
    );
  }

  @override
  String toString() {
    return "Restaurant{id: $id, idType: $idType, nomRestaurant: $nomRestaurant, horaires: $horaires, siret: $siret, numTel: $numTel, urlWeb: $urlWeb, commune: $commune, vegetarien: $vegetarien, vegan: $vegan, entreeFauteuilRoulant: $entreeFauteuilRoulant, accessInternet: $accessInternet,  marque: $marque,  nbEtoiles: $nbEtoiles,  urlFacebook: $urlFacebook}";
  }
}