
import 'package:flutter/material.dart';
import 'livre.dart';
import 'screens/parametres_screen.dart';

void main() {
  runApp(const MaBiblioApp());
}

class MaBiblioApp extends StatelessWidget {
  const MaBiblioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaBiblio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// Trois livres temporaires pour tester l'affichage.
final List<Livre> livres = [
  Livre(
    id: 1,
    titre: 'Le Petit Prince',
    auteur: 'Antoine de Saint-Exupéry',
    genre: 'Roman',
    annee: 1943,
    note: 4.8,
    couleur: Colors.orange,
  ),
  Livre(
    id: 2,
    titre: 'Une brève histoire du temps',
    auteur: 'Stephen Hawking',
    genre: 'Science',
    annee: 1988,
    note: 4.6,
    couleur: Colors.blue,
  ),
  Livre(
    id: 3,
    titre: 'Clean Code',
    auteur: 'Robert C. Martin',
    genre: 'Informatique',
    annee: 2008,
    note: 4.9,
    couleur: Colors.green,
  ),
];

// Q1.7 : construire une ligne représentant un livre.
Widget livreTile(Livre livre) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: livre.couleur,
      child: Text(
        livre.titre.isNotEmpty
            ? livre.titre[0].toUpperCase()
            : '?',
        style: const TextStyle(color: Colors.white),
      ),
    ),
    title: Text(livre.titre),
    subtitle: Text('${livre.auteur} – ${livre.annee}'),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(livre.note.toString()),
        const SizedBox(width: 4),
        const Icon(
          Icons.star,
          color: Colors.amber,
        ),
      ],
    ),
  );
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
      body: ListView(
        children: livres.take(3).map(livreTile).toList(),
      ),
    );
  }
}
