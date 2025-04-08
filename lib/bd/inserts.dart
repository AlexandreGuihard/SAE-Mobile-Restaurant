import 'package:sae_mobile/bd/cuisine_provider.dart';
import 'package:sae_mobile/bd/emplacement_provider.dart';
import 'package:sae_mobile/model/emplacement.dart';

import '../model/cuisine.dart';

class Inserts{
  final bd;
  
  const Inserts(this.bd);
  
  void insertData(){
    var cuisineProvider=CuisineProvider(db:bd, supabase: null);
    //cuisineProvider.insertCuisine(Cuisine(id: 1, type: "Gastronomique"));
    //cuisineProvider.insertCuisine(Cuisine(id: 2, type: "Fast-Food"));

    var emplacemementProvider=EmplacementProvider(db:bd, supabase: null);
    //emplacemementProvider.insertEmplacement(Emplacement(commune: "Paris", numDepartement: 75, departement: "Paris"));
    //emplacemementProvider.insertEmplacement(Emplacement(commune: "Orléans", numDepartement: 45, departement: "Loiret"));
    //emplacemementProvider.insertEmplacement(Emplacement(commune: "Bourges", numDepartement: 18, departement: "Cher"));
  }
}