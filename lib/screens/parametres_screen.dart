
import 'package:flutter/material.dart';

class ParametresScreen extends StatelessWidget {
  const ParametresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> parametres = [
      ListTile(
        leading: const Icon(Icons.person),
        title: const Text('Mon profil'),
        subtitle: const Text('Nom, e-mail, mot de passe'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profil sélectionné'),
            ),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.notifications),
        title: const Text('Notifications'),
        tileColor: Colors.blue.shade50,
        iconColor: Colors.blue,
        textColor: Colors.blue.shade900,
      ),
      const ListTile(
        leading: Icon(Icons.language),
        title: Text('Langue'),
        subtitle: Text('Français'),
        trailing: Icon(Icons.chevron_right),
      ),
      const ListTile(
        leading: Icon(Icons.info),
        title: Text('À propos'),
        subtitle: Text('MaBiblio\nVersion 1.0'),
        isThreeLine: true,
        enabled: false,
      ),

      // Dix éléments supplémentaires pour tester le défilement.
      ...List.generate(
        10,
        (index) => ListTile(
          leading: const Icon(Icons.settings),
          title: Text('Paramètre ${index + 1}'),
          subtitle: const Text('Élément de test'),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: ListTile.divideTiles(
          context: context,
          tiles: parametres,
        ).toList(),
      ),
    );
  }
}
