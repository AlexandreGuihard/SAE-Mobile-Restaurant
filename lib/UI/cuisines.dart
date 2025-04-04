import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sae_mobile/bd/cuisine_provider.dart';
import 'package:sae_mobile/model/cuisine.dart';

class CuisinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Les cuisines disponibles'),
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
      body: FutureBuilder<List<Cuisine>>(
        future: context.watch<CuisineProvider>().getCuisinesSupabase(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Cuisine> lesCuisines = snapshot.data!;
            return ListView.builder(
              itemCount: lesCuisines.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.restaurant, size: 40),
                      const SizedBox(width: 20),
                    ],
                  ),
                  title: Text(lesCuisines[index].type),
                );
              },
            );
          }
          return Center(child: Text('Aucune cuisine trouvée.'));
        },
      ),
    );
  }
}
