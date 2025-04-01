import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sae_mobile/bd/restaurant_provider.dart';
import 'package:sae_mobile/model/restaurant.dart';

import 'detail.dart';

class RestaurantsPage extends StatelessWidget {
  RestaurantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    String sortBy = 'Nom';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nos Restaurants'),
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
        ],
      ),
      backgroundColor: Colors.white60,
      body: FutureBuilder<List<Restaurant>>(
        future: context.watch<RestaurantProvider>().getRestaurantsSupabase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done &&
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucun restaurant trouvé."));
          }
          List<Restaurant> restaurants = snapshot.data!;
          return StatefulBuilder(
            builder: (context, setState) {
              // Filtrage des restaurants selon la recherche
              List<Restaurant> filteredRestaurants = restaurants
                  .where((restaurant) => restaurant.nomRestaurant
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()))
                  .toList();
              filteredRestaurants.sort((a, b) {
                return (sortBy == 'Nom')
                    ? a.nomRestaurant.compareTo(b.nomRestaurant)
                    : b.nbEtoiles.compareTo(a.nbEtoiles);
              });
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        labelText: 'Rechercher un restaurant...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) => setState(() {}),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton<String>(
                      value: sortBy,
                      isExpanded: true,
                      items: ['Nom', 'Note'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text('Trier par $value'),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          sortBy = newValue!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredRestaurants.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.restaurant, size: 40),
                              const SizedBox(width: 20),
                              const CircleAvatar(
                                backgroundImage:
                                AssetImage('images/exemple_restaurant.jpg'),
                                radius: 20,
                              ),
                            ],
                          ),
                          title: Text(filteredRestaurants[index].nomRestaurant),
                          subtitle: Text(
                              'Note: ${filteredRestaurants[index].nbEtoiles} ⭐'),
                          onTap: () {
                            Navigator.pushNamed(context, '/detail');
                          },
                        );
                      },
                    ),
                    title: Text(snapshot.data![index].nomRestaurant),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(restaurant: snapshot.data![index])));
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