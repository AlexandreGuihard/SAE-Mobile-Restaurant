import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sae_mobile/UI/AppNavigation.dart';
import 'package:sae_mobile/bd/cuisine_provider.dart';
import 'package:sae_mobile/bd/emplacement_provider.dart';
import 'package:sae_mobile/bd/restaurant_provider.dart';
import 'package:sae_mobile/bd/tables.dart';
import 'package:sae_mobile/bd/type_restaurant_provider.dart';
import 'package:sae_mobile/bd/utilisateur_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sae_mobile/UI/home.dart';
import 'package:sae_mobile/UI/detail.dart';
import 'package:sae_mobile/UI/cuisines.dart';
import 'package:sae_mobile/UI/connection.dart';
import 'package:sae_mobile/model/restaurant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'bd/avis_provider.dart';
import 'bd/inserts.dart';
import 'model/cuisine.dart';

late SupabaseClient supabase;
late Database db;

void main() async {
  // Connexion BD
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  } else {
    if (Platform.isLinux || Platform.isWindows) {
      databaseFactory = databaseFactoryFfi;
      sqfliteFfiInit();
    }
  }
  print("Connexion sqflite établie");
  db = await openDatabase(inMemoryDatabasePath);
  TablesBd.addTables(db);
  var inserts=Inserts(db);
  inserts.insertData();

  // Connexion supabase
  await Supabase.initialize(
    url: 'https://bhgnkwowmmjrtnpwmeyn.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJoZ25rd293bW1qcnRucHdtZXluIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzczODQ0NjksImV4cCI6MjA1Mjk2MDQ2OX0.QX6i2drDaaHv-vcJ4TlJn1RaTO_7CBuAVCDxaNMq02g',
  );
  supabase=Supabase.instance.client;
  supabase.from("cuisine").insert(Cuisine(id: 3, type: "aaa"));
  print("Connexion Supabase établie");
  // App et providers pour la bd
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CuisineProvider(db: db, supabase: supabase)),
            ChangeNotifierProvider(create: (context) => EmplacementProvider(db: db, supabase: supabase)),
            ChangeNotifierProvider(create: (context) => RestaurantProvider(db: db, supabase: supabase)),
            ChangeNotifierProvider(create: (context) => TypeRestaurantProvider(db: db, supabase: supabase)),
            ChangeNotifierProvider(create: (context) => UtilisateurProvider(db: db, supabase: supabase)),
            ChangeNotifierProxyProvider2<UtilisateurProvider, RestaurantProvider, AvisProvider>(
              create: (context) => AvisProvider(
                db: db,
                supabase: supabase,
                utilisateurProvider: context.read<UtilisateurProvider>(),
                restaurantProvider: context.read<RestaurantProvider>(),
              ),
              update: (context, utilisateurProvider, restaurantProvider, previous) =>
                  AvisProvider(db: db, supabase: supabase, utilisateurProvider: utilisateurProvider, restaurantProvider: restaurantProvider),
            ),
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Restaurants",
              routes: {
                '/': (context) => AppNavigation(),
                '/connection': (context) => MyCustomForm(),
                '/profil/favoris/restaurants': (context) => MyCustomForm(),
                '/profil/favoris/cuisine': (context) => MyCustomForm(),
                '/cuisines' : (context) => CuisinePage(),
              },
              initialRoute: '/connection',
          )
      )
  );
}