import 'package:flutter/material.dart';

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
}