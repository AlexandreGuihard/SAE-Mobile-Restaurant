import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sae_mobile/bd/restaurant_provider.dart';
import 'package:sae_mobile/model/restaurant.dart';

class RestaurantsPage extends StatelessWidget {
  late Future<List<Restaurant>> restaurants;

  RestaurantsPage({super.key});


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.watch<RestaurantProvider>().getRestaurantsSupabase(),
        builder: (context, snapshot) {
          if ( snapshot.connectionState!=ConnectionState.done && !snapshot.hasData){

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {

            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.data != null) {
            return Scaffold(
              appBar: AppBar(
                  title: Text('Nos Restaurants'),
                  centerTitle: true,
                  backgroundColor: Colors.green,
                  actions: <Widget>[
                    IconButton(
                      icon: Image.asset('images/logo.png'),
                      tooltip: 'Accueil',
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                    ),
                  ]
              ),
              backgroundColor: Colors.white60,
              body: ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      height: 80.0,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.restaurant, size: 40),
                          SizedBox(width: 20),
                          CircleAvatar(
                            backgroundImage: AssetImage('images/exemple_restaurant.jpg'),
                            radius: 20,
                          ),
                        ],
                      ),
                    ),
                    title: Text(snapshot.data![index].nomRestaurant),
                    subtitle:Text('Note: ${snapshot.data![index].nbEtoiles} ⭐'),
                    onTap: () {
                      Navigator.pushNamed(context, '/detail');
                    },
                  );
                },
              ),
            );
          }
          return Container();
      }
    );
  }
}