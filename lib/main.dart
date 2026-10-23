
import 'package:flutter/material.dart';

import 'models/livre.dart';
import 'data/livres_data.dart';
import 'screens/parametres_screen.dart';
import 'screens/catalogue_screen.dart';
import 'screens/ma_liste_screen.dart';

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
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MaBiblio'),
        actions: [
          // Bouton Catalogue
          IconButton(
            icon: const Icon(Icons.menu_book),
            tooltip: 'Catalogue',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CatalogueScreen(
                    livres: livres,
                  ),
                ),
              );
            },
          ),

          // Bouton Ma liste
          IconButton(
            icon: const Icon(Icons.checklist),
            tooltip: 'Ma liste',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MaListeScreen(),
                ),
              );
            },
          ),

          // Bouton Paramètres
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Paramètres',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ParametresScreen(),
                ),
              );
            },
          ),
        ],
      ),

      // Page d'accueil : affichage des trois premiers livres
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Bienvenue dans MaBiblio',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...livres.take(3).map((livre) {
            return livreTile(livre);
          }),
        ],
      ),
    );
  }
}

// Widget d'affichage d'un livre
Widget livreTile(Livre livre) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: livre.couleur,
      child: Text(
        livre.titre.isNotEmpty ? livre.titre[0] : '?',
        style: const TextStyle(
          color: Colors.white,
        ),
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
