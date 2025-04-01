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
      'idrestaurant': id,
      'idtype': idType,
      'nomrestaurant': nomRestaurant,
      'horaires': horaires,
      'siret': siret,
      'numtel': numTel,
      'urlweb': urlWeb,
      'commune': commune,
      'vegetarien': vegetarien,
      'vegan': vegan,
      'entreefauteuilroulant': entreeFauteuilRoulant,
      'accessinternet': accessInternet,
      'marquerestaurant': marque,
      'nbetoiles': nbEtoiles,
      'urlfacebook': urlFacebook
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['idrestaurant'],
      idType: map['idtype'],
      nomRestaurant: map['nomrestaurant'],
      horaires: map['horaires'],
      siret: map['siret'],
      numTel: map['numtel'],
      urlWeb: map['urlweb'],
      commune: map['commune'],
      vegetarien: map['vegetarien'],
      vegan: map['vegan'],
      entreeFauteuilRoulant: map['entreefauteuilroulant'],
      accessInternet: map['accesinternet'],
      marque: map['marquerestaurant'],
      nbEtoiles: map['nbetoiles'],
      urlFacebook: map['urlfacebook'],
    );
  }

  @override
  String toString() {
    return "Restaurant{id: $id, idType: $idType, nomRestaurant: $nomRestaurant, horaires: $horaires, siret: $siret, numTel: $numTel, urlWeb: $urlWeb, commune: $commune, vegetarien: $vegetarien, vegan: $vegan, entreeFauteuilRoulant: $entreeFauteuilRoulant, accessInternet: $accessInternet,  marque: $marque,  nbEtoiles: $nbEtoiles,  urlFacebook: $urlFacebook}";
  }
}