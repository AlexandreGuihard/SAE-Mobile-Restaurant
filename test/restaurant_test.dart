import 'package:flutter_test/flutter_test.dart';
import 'package:sae_mobile/bd/restaurant_provider.dart';
import 'package:sae_mobile/main.dart';
import 'package:sae_mobile/model/restaurant.dart';

void main() async{
  group("Tests sur les restaurants", (){
    test("Get d'un restaurant de la bd", (){
      final Restaurant lePetitGourmet=Restaurant(
          id: 1,
          idType: 2,
          nomRestaurant: "Le Petit Gourmet",
          horaires: "08:00-22:00",
          siret: "12345678901234",
          numTel: "0123456789",
          urlWeb: "http://lepetitgourmet.fr",
          commune: "Paris",
          vegetarien: false,
          vegan: false,
          entreeFauteuilRoulant: true,
          accessInternet: true,
          marque: "Indépendant",
          nbEtoiles: 4,
          urlFacebook: "http://facebook.com/lepetitgourmet"
      );

      final Restaurant laBellaPizza=Restaurant(
          id: 2,
          idType: 5,
          nomRestaurant: "La Bella Pizza",
          horaires: "11:00-23:00",
          siret: "23456789012345",
          numTel: "0987654321",
          urlWeb: "http://labellapizza.it",
          commune: "Lyon",
          vegetarien: true,
          vegan: false,
          entreeFauteuilRoulant: true,
          accessInternet: true,
          marque: "Franchise",
          nbEtoiles: 5,
          urlFacebook: "http://facebook.com/labellapizza"
      );

      final RestaurantProvider provider=RestaurantProvider(db: db, supabase: supabase);
      expect(provider.getRestaurantFromIdSupabase(1), lePetitGourmet);
      expect(provider.getRestaurantFromIdSupabase(2), laBellaPizza);
    });
  });
}