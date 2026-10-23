
import 'package:flutter/material.dart';
import '../models/livre.dart';
import '../data/livres_data.dart';

class MaListeScreen extends StatefulWidget {
  const MaListeScreen({super.key});

  @override
  State<MaListeScreen> createState() => _MaListeScreenState();
}

class _MaListeScreenState extends State<MaListeScreen> {
  // Q3.2 : filtre des nouveautés
  bool _nouveautesSeulement = false;

  // Q3.3 : les cinq genres réels, tous cochés au départ
  final Map<String, bool> _genres = {
    'Jeunesse': true,
    'Roman': true,
    'Science': true,
    'Histoire': true,
    'Informatique': true,
  };

  // Q3.4 : icône adaptée à chaque genre
  IconData _iconeGenre(String genre) {
    switch (genre) {
      case 'Jeunesse':
        return Icons.child_care;
      case 'Roman':
        return Icons.menu_book;
      case 'Science':
        return Icons.science;
      case 'Histoire':
        return Icons.history_edu;
      case 'Informatique':
        return Icons.computer;
      default:
        return Icons.book;
    }
  }

  // Q3.6 : état de la case "Tous les genres"
  bool? get _tousLesGenres {
    final nombreCoches =
        _genres.values.where((selectionne) => selectionne).length;

    if (nombreCoches == _genres.length) return true;
    if (nombreCoches == 0) return false;
    return null;
  }

  // Q3.7 : filtrer les livres par genre et nouveautés
  List<Livre> get _livresFiltres {
    return livres.where((livre) {
      final genreSelectionne = _genres[livre.genre] ?? false;
      final nouveauteAcceptee =
          !_nouveautesSeulement || livre.nouveaute;

      return genreSelectionne && nouveauteAcceptee;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final livresAffiches = _livresFiltres;
    final nombreLus =
        livresAffiches.where((livre) => livre.lu).length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lus : $nombreLus / ${livresAffiches.length}'),
      ),
      body: Column(
        children: [
          // Q3.2 : filtre des nouveautés
          CheckboxListTile(
            title: const Text(
              'Afficher uniquement les nouveautés',
            ),
            value: _nouveautesSeulement,
            activeColor: Colors.teal,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              setState(() {
                _nouveautesSeulement = value ?? false;
              });
            },
          ),

          const Divider(height: 1),

          // Q3.6 : tous les genres
          CheckboxListTile(
            title: const Text('Tous les genres'),
            tristate: true,
            value: _tousLesGenres,
            activeColor: Colors.teal,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              setState(() {
                final toutCocher = _tousLesGenres != true;

                for (final genre in _genres.keys.toList()) {
                  _genres[genre] = toutCocher;
                }
              });
            },
          ),

          // Q3.3 à Q3.5 : cases des genres
          ..._genres.keys.map((genre) {
            final nombreLivres = livres
                .where((livre) => livre.genre == genre)
                .length;

            return CheckboxListTile(
              title: Text(genre),
              subtitle: Text('$nombreLivres livre(s)'),
              secondary: Icon(_iconeGenre(genre)),
              value: _genres[genre]!,
              activeColor: Colors.teal,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                setState(() {
                  _genres[genre] = value ?? false;
                });
              },
            );
          }),

          const Divider(height: 1),

          // Q3.7 : vraie liste séparée, filtrée
          Expanded(
            child: ListView.separated(
              itemCount: livresAffiches.length,
              separatorBuilder: (context, index) =>
                  const Divider(indent: 72, height: 1),
              itemBuilder: (context, index) {
                final livre = livresAffiches[index];

                return CheckboxListTile(
                  value: livre.lu,
                  controlAffinity: ListTileControlAffinity.leading,
                  secondary: CircleAvatar(
                    backgroundColor: livre.couleur,
                    child: Text(
                      livre.titre.isNotEmpty
                          ? livre.titre[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    livre.titre,
                    style: TextStyle(
                      decoration: livre.lu
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(
                    '${livre.auteur} - ${livre.annee}',
                  ),
                  onChanged: (value) {
                    setState(() {
                      livre.lu = value ?? false;
                    });
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
