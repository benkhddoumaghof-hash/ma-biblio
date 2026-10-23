
import 'package:flutter/material.dart';
import '../models/livre.dart';

class DetailScreen extends StatefulWidget {
  final Livre livre;

  const DetailScreen({
    super.key,
    required this.livre,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final livre = widget.livre;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail du livre'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Bandeau du livre
              Container(
                height: 200,
                color: livre.couleur,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Text(
                  livre.titre,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              // Informations du livre
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Auteur'),
                subtitle: Text(livre.auteur),
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Année'),
                subtitle: Text(livre.annee.toString()),
              ),
              ListTile(
                leading: const Icon(Icons.category),
                title: const Text('Genre'),
                subtitle: Text(livre.genre),
              ),

              // Boutons d'action
              Padding(
                padding: const EdgeInsets.all(12),
                child: OverflowBar(
                  alignment: MainAxisAlignment.end,
                  spacing: 8,
                  overflowSpacing: 8,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          livre.favori = !livre.favori;
                        });
                      },
                      icon: Icon(
                        livre.favori
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      label: Text(
                        livre.favori
                            ? 'Retirer des favoris'
                            : 'Ajouter aux favoris',
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          livre.lu = !livre.lu;
                        });
                      },
                      icon: Icon(
                        livre.lu
                            ? Icons.check_circle
                            : Icons.menu_book,
                      ),
                      label: Text(
                        livre.lu
                            ? 'Marqué comme lu'
                            : 'Marquer comme lu',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
