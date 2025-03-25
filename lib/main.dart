import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sae_mobile/bd/cuisine_provider.dart';
import 'package:sae_mobile/bd/emplacement_provider.dart';
import 'package:sae_mobile/bd/restaurant_provider.dart';
import 'package:sae_mobile/bd/tables.dart';
import 'package:sae_mobile/bd/type_restaurant_provider.dart';
import 'package:sae_mobile/bd/utilisateur_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import 'bd/inserts.dart';

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
  var db = await openDatabase(inMemoryDatabasePath);
  TablesBd.addTables(db);
  var inserts=Inserts(db);
  inserts.insertData();

  // App et providers pour la bd
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CuisineProvider(db: db)),
        ChangeNotifierProvider(create: (context) => EmplacementProvider(db: db)),
        ChangeNotifierProvider(create: (context) => RestaurantProvider(db: db)),
        ChangeNotifierProvider(create: (context) => TypeRestaurantProvider(db: db)),
        ChangeNotifierProvider(create: (context) => UtilisateurProvider(db: db))
      ],
      child: App()
    )
  );
}

class App extends StatelessWidget{}
