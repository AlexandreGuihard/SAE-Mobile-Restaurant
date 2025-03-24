import 'package:flutter/material.dart';
import 'package:sae_mobile/UI/home.dart';
import 'package:sae_mobile/UI/detail.dart';
import 'package:sae_mobile/UI/connection.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Restaurants",
      routes: {
        '/': (context) => RestaurantsPage(),
        '/detail': (context) => DetailPage(),
        '/connection': (context) => MyCustomForm(),
      },
      initialRoute: '/connection'
      ));
  }
