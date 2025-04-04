import 'package:flutter_test/flutter_test.dart';
import 'package:sae_mobile/bd/cuisine_provider.dart';
import 'package:sae_mobile/model/cuisine.dart';
import 'package:sae_mobile/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final CuisineProvider provider=CuisineProvider.supabaseOnly(supabase: supabase);

void main(){
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await Supabase.initialize(
      url: 'https://bhgnkwowmmjrtnpwmeyn.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJoZ25rd293bW1qcnRucHdtZXluIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzczODQ0NjksImV4cCI6MjA1Mjk2MDQ2OX0.QX6i2drDaaHv-vcJ4TlJn1RaTO_7CBuAVCDxaNMq02g',
    );
    supabase = Supabase.instance.client;
  });
  group("Tests sur la classe Cuisine", (){
    test("Get une cuisine de la bd", () async{
      final Cuisine cuisineFrancaise=Cuisine(id: 1, type: "Francaise");
      final Cuisine cuisineItalienne=Cuisine(id: 2, type: "Italienne");
      expect(await provider.getCuisineFromIdSupabase(1), cuisineFrancaise);
      expect(await provider.getCuisineFromIdSupabase(2), cuisineItalienne);
    });

    test("Get toutes les cuisines de la bd", () async{
      final List<Cuisine> cuisines=List.of([Cuisine(id: 1, type: "Francaise"), Cuisine(id: 2, type: "Italienne")]);
      expect(await provider.getCuisinesSupabase(), cuisines);
    });
  });
}