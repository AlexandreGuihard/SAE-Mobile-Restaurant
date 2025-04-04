import 'package:flutter_test/flutter_test.dart';
import 'package:sae_mobile/bd/type_restaurant_provider.dart';
import 'package:sae_mobile/main.dart';
import 'package:sae_mobile/model/typerestaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final TypeRestaurantProvider provider=TypeRestaurantProvider.supabaseOnly(supabase: supabase);

void main(){
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await Supabase.initialize(
      url: 'https://bhgnkwowmmjrtnpwmeyn.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJoZ25rd293bW1qcnRucHdtZXluIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzczODQ0NjksImV4cCI6MjA1Mjk2MDQ2OX0.QX6i2drDaaHv-vcJ4TlJn1RaTO_7CBuAVCDxaNMq02g',
    );
    supabase = Supabase.instance.client;
  });
  group("Tests sur la classe TypeRestaurant", (){
    test("Get un type de la bd", () async{
      final TypeRestaurant fastFood=TypeRestaurant(id: 1, type: "Fast Food");
      final TypeRestaurant bistrot=TypeRestaurant(id: 2, type: "Bistrot");
      expect(await provider.getTypeRestaurantFromIdSupabase(1), fastFood);
      expect(await provider.getTypeRestaurantFromIdSupabase(2), bistrot);
    });
    test("Get tous les types de la bd", () async{
      final List<TypeRestaurant> types=List.of([
        TypeRestaurant(id: 1, type: "Fast Food"),
        TypeRestaurant(id: 2, type: "Bistrot"),
        TypeRestaurant(id: 3, type: "Gastronomique"),
        TypeRestaurant(id: 4, type: "Végétarien"),
        TypeRestaurant(id: 5, type: "Pizzeria")
      ]);
      expect(await provider.getTypesRestaurantsSupabase(), types);
    });
  });
}