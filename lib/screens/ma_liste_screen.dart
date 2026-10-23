
import 'package:flutter/material.dart';
import '../models/livre.dart';
import '../data/livres_data.dart';

class MaListeScreen extends StatefulWidget {
  const MaListeScreen({super.key});

  @override
  State<MaListeScreen> createState() => _MaListeScreenState();
}

class _MaListeScreenState extends State<MaListeScreen> {
  bool _nouveautesSeulement = false;

  final Map<String, bool> _genres = {
    'Science': true,
    'Informatique': true,
    'Roman': true,
    'Histoire': true,
    'Fantastique': true,
  };

  IconData _iconeGenre(String genre) {
    switch (genre) {
      case 'Science':
        return Icons.science;
      case 'Informatique':
        return Icons.computer;
      case 'Roman':
        return Icons.menu_book;
      case 'Histoire':
        return Icons.history_edu;
      case 'Fantastique':
        return Icons.auto_awesome;
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

  // Q3.7 : filtrage des livres
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
    final nombreLus = livresAffiches.where((livre) => livre.lu).length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lus : $nombreLus / ${livresAffiches.length}'),
      ),
      body: ListView(
        children: [
          // Q3.2 : filtre des nouveautés
          CheckboxListTile(
            title: const Text('Afficher uniquement les nouveautés'),
            value: _nouveautesSeulement,
            activeColor: Colors.teal,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              setState(() {
                _nouveautesSeulement = value ?? false;
              });
            },
          ),

          const Divider(),

          // Q3.6 : sélection de tous les genres
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
            final nombreLivres =
                livres.where((livre) => livre.genre == genre).length;

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

          const Divider(),

          // Q3.7 : affichage des livres avec séparateurs
          ..._construireListeLivres(livresAffiches),
        ],
      ),
    );
  }

  List<Widget> _construireListeLivres(List<Livre> livresAffiches) {
    if (livresAffiches.isEmpty) {
      return [
        const Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Text('Aucun livre ne correspond aux filtres.'),
          ),
        ),
      ];
    }

    final widgets = <Widget>[];

    for (final livre in livresAffiches) {
      widgets.add(
        CheckboxListTile(
          value: livre.lu,
          controlAffinity: ListTileControlAffinity.leading,
          secondary: CircleAvatar(
            backgroundColor: livre.couleur,
            child: Text(
              livre.titre.isNotEmpty ? livre.titre[0] : '?',
              style: const TextStyle(color: Colors.white),
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
          subtitle: Text('${livre.auteur} – ${livre.annee}'),
          onChanged: (value) {
            setState(() {
              livre.lu = value ?? false;
            });
          },
        ),
      );
    }

    return List<Widget>.generate(
      widgets.length * 2 - 1,
      (index) {
        if (index.isOdd) {
          return const Divider(indent: 72, height: 1);
        }
        return widgets[index ~/ 2];
      },
    );
  }
}
