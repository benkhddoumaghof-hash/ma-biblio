
import 'package:flutter/material.dart';
import 'models/livre.dart';
import 'data/livres_data.dart';
import 'screens/parametres_screen.dart';
import 'screens/catalogue_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaBiblio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MaBiblio'),
        actions: [
          // Bouton pour ouvrir le catalogue
          IconButton(
            icon: const Icon(Icons.menu_book),
            tooltip: 'Catalogue',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CatalogueScreen(livres: livres),
                ),
              );
            },
          ),

          // Bouton pour ouvrir les paramètres
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Paramètres',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const ParametresScreen(),
                ),
              );
            },
          ),
        ],
      ),

      // Affichage des trois premiers livres sur l'accueil
      body: ListView(
        children: livres.take(3).map((livre) {
          return livreTile(livre);
        }).toList(),
      ),
    );
  }
}

// Widget réutilisable pour afficher un livre
Widget livreTile(Livre livre) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: livre.couleur,
      child: Text(
        livre.titre[0],
        style: const TextStyle(color: Colors.white),
      ),
    ),
    title: Text(livre.titre),
    subtitle: Text('${livre.auteur} – ${livre.annee}'),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(livre.note.toString()),
        const Icon(
          Icons.star,
          color: Colors.amber,
        ),
      ],
    ),
  );
}
