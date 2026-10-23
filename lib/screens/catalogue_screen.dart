
import 'package:flutter/material.dart';
import '../models/livre.dart';
import '../widgets/livre_card.dart';
import 'detail_screen.dart';

class CatalogueScreen extends StatelessWidget {
  final List<Livre> livres;

  const CatalogueScreen({
    super.key,
    required this.livres,
  });

  @override
  Widget build(BuildContext context) {
    // Récupérer uniquement les nouveautés
    final nouveautes =
        livres.where((livre) => livre.nouveaute).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section horizontale : Nouveautés
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Nouveautés',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(
            height: 180,
            child: nouveautes.isEmpty
                ? const Center(
                    child: Text('Aucune nouveauté disponible'),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: nouveautes.length,
                    itemBuilder: (context, index) {
                      final livre = nouveautes[index];

                      return SizedBox(
                        width: 300,
                        child: LivreCard(
                          livre: livre,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(livre: livre),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),

          // Section verticale : Tous les livres
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Tous les livres',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: livres.length,
              itemBuilder: (context, index) {
                final livre = livres[index];

                return LivreCard(
                  livre: livre,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(livre: livre),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
