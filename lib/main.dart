import 'package:flutter/material.dart';
import 'package:sae_mobile/UI/home.dart';
import 'package:sae_mobile/UI/detail.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Restaurants",
      routes: {
        '/': (context) => RestaurantsPage(),
        '/secondPage': (context) => DetailPage(),
      },
      initialRoute: '/'
      ));
  }
