import 'package:flutter_test/flutter_test.dart';
import 'package:sae_mobile/bd/cuisine_provider.dart';
import 'package:sae_mobile/model/cuisine.dart';
import 'package:sae_mobile/main.dart';

void main(){
  group("Tests sur la classe Cuisine", (){
    test("Get une cuisine de la bd", (){
      final Cuisine cuisineFrancaise=Cuisine(id: 1, type: "Francaise");
      final Cuisine cuisineItalienne=Cuisine(id: 2, type: "Italienne");
      final CuisineProvider provider=CuisineProvider(db: db, supabase: supabase);
      expect(provider.getCuisineFromIdSupabase(1), cuisineFrancaise);
      expect(provider.getCuisineFromIdSupabase(2), cuisineItalienne);
    });
  });
}