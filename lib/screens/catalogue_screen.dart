
import 'package:flutter/material.dart';
import '../models/livre.dart';
import '../widgets/livre_tile.dart';

// ListView.builder et ListView.separated construisent les éléments
// au fur et à mesure du défilement. Pour 1 000 livres, cela évite
// de créer immédiatement les 1 000 widgets, contrairement à
// ListView(children: [...]) qui reçoit tous les enfants à l'avance.

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({
    super.key,
    required this.livres,
  });

  final List<Livre> livres;

  @override
  Widget build(BuildContext context) {
    final nouveautes = livres.where((livre) => livre.nouveaute).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Nouveautés',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: nouveautes.map((livre) {
                return Container(
                  width: 110,
                  margin: const EdgeInsets.only(right: 8),
                  color: livre.couleur,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    livre.titre,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Tout le catalogue',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: ListView.separated(
              itemCount: livres.length,
              itemBuilder: (context, index) {
                return livreTile(livres[index]);
              },
              separatorBuilder: (context, index) {
                return const Divider(indent: 72);
              },
            ),
          ),
        ],
      ),
    );
  }
}
