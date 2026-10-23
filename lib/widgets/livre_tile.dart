
import 'package:flutter/material.dart';
import '../models/livre.dart';

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
    subtitle: Text('${livre.auteur} - ${livre.annee}'),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(livre.note.toString()),
        const SizedBox(width: 4),
        const Icon(Icons.star, color: Colors.amber),
      ],
    ),
  );
}
