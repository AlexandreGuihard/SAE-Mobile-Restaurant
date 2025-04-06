import 'package:flutter_test/flutter_test.dart';
import 'package:sae_mobile/bd/emplacement_provider.dart';
import 'package:sae_mobile/main.dart';
import 'package:sae_mobile/model/emplacement.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final EmplacementProvider provider=EmplacementProvider.supabaseOnly(supabase: supabase);

void main(){
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await Supabase.initialize(
      url: 'https://bhgnkwowmmjrtnpwmeyn.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJoZ25rd293bW1qcnRucHdtZXluIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzczODQ0NjksImV4cCI6MjA1Mjk2MDQ2OX0.QX6i2drDaaHv-vcJ4TlJn1RaTO_7CBuAVCDxaNMq02g',
    );
    supabase = Supabase.instance.client;
  });
  group("Tests sur les emplacements des restaurants", (){
    test("Get d'emplacements de la bd", () async{
      final Emplacement bourges=Emplacement(commune: "Bourges", numDepartement: 18, departement: "Cher");
      final Emplacement paris=Emplacement(commune: "Paris", numDepartement: 75, departement: "Paris");
      expect(await provider.getEmplacementFromCommuneSupabase("Bourges"), bourges);
      expect(await provider.getEmplacementFromCommuneSupabase("Paris"), paris);
    });
    test("Get tous les emplacements de la bd", () async{
      final List<Emplacement> emplacements=List.of([
        Emplacement(commune: "Paris", numDepartement: 75, departement: "Paris"),
        Emplacement(commune: "Lyon", numDepartement: 69, departement: "Rhone"),
        Emplacement(commune: "Bordeaux", numDepartement: 33, departement: "Gironde"),
        Emplacement(commune: "Marseille", numDepartement: 13, departement: "Bouches du Rhone"),
        Emplacement(commune: "Toulouse", numDepartement: 31, departement: "Haute Garonne"),
        Emplacement(commune: "Orléans", numDepartement: 45, departement: "Loiret"),
        Emplacement(commune: "Bourges", numDepartement: 18, departement: "Cher")]);
      expect(await provider.getEmplacementsSupabase(), emplacements);
    });
  });
}