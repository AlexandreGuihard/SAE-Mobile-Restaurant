import 'package:flutter/material.dart';

class RestaurantsPage extends StatelessWidget {
  final List<Map<String, dynamic>> restaurants = [
    {'name': 'Le Gourmet', 'rating': 4.5},
    {'name': 'Pizza Pasta', 'rating': 4.2},
    {'name': 'Sushi Express', 'rating': 4.8},
    {'name': 'Bistro Parisien', 'rating': 4.0},
    {'name': 'Tacos Mania', 'rating': 3.8},
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    String sortBy = 'Nom';

    return StatefulBuilder(
      builder: (context, setState) {
        List<Map<String, dynamic>> filteredRestaurants = restaurants
            .where((restaurant) =>
            restaurant['name'].toLowerCase().contains(searchController.text.toLowerCase()))
            .toList();
        filteredRestaurants.sort((a, b) {
          if (sortBy == 'Nom') {
            return a['name'].compareTo(b['name']);
          } else {
            return b['rating'].compareTo(a['rating']);
          }
        });

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
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Rechercher un restaurant...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
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
              ListView.builder(
                shrinkWrap: true,
                itemCount: filteredRestaurants.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      height: 80.0,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.restaurant, size: 40),
                          const SizedBox(width: 20),
                          const CircleAvatar(
                            backgroundImage:
                            AssetImage('images/exemple_restaurant.jpg'),
                            radius: 20,
                          ),
                        ],
                      ),
                    ),
                    title: Text(filteredRestaurants[index]['name']),
                    subtitle:
                    Text('Note: ${filteredRestaurants[index]['rating']} ⭐'),
                    onTap: () {
                      Navigator.pushNamed(context, '/detail');
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}