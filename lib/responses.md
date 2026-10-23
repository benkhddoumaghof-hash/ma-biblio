# Réponses aux questions de réflexion

## Partie 01 — ListTile

**1. Quelle est la différence entre leading et trailing ? Pourquoi un ListTile doit-il être placé dans un parent à largeur contrainte ?**

`leading` permet d'afficher un élément au début du ListTile, par exemple une icône de livre. `trailing` permet d'afficher un élément à la fin, comme une flèche ou une case à cocher.

Le ListTile a besoin d'une largeur définie pour bien afficher son contenu. Sinon, Flutter peut rencontrer un problème de mise en page.

## Partie 02 — ListView

**Q2.1. Quel message d'erreur apparaît ? Pourquoi ?**

Le message est généralement `A RenderFlex overflowed by ... pixels on the bottom`. Il apparaît parce que la Column contient trop d'éléments pour la hauteur de l'écran. Les éléments dépassent et Flutter affiche une bande jaune et noire.

**Q2.2. Pourquoi remplacer Column par ListView ?**

Avec Column, tous les éléments doivent tenir sur l'écran. ListView permet de faire défiler la liste pour accéder aux éléments qui ne sont pas visibles. Le padding de 8 ajoute un petit espace autour de la liste.

**Q2.3. Quel est l'avantage de ListTile.divideTiles() ?**

Cette méthode permet d'ajouter des séparateurs entre les ListTile sans devoir mettre un Divider après chaque élément. Le code est donc plus simple.

**Q2.4. Quel est le rôle de ListView.builder ?**

ListView.builder permet d'afficher les livres à partir de leur liste. Il construit les éléments au fur et à mesure qu'ils deviennent nécessaires à l'affichage, en utilisant itemBuilder et itemCount.

**Q2.5. Pourquoi utiliser ListView.builder pour 1 000 livres ?**

Parce qu'il ne construit pas tous les éléments dès le début. Il construit principalement ceux qui sont nécessaires à l'affichage, ce qui permet d'économiser des ressources et d'améliorer les performances.

**Q2.6. Quel est l'intérêt de ListView.separated ?**

ListView.separated permet d'ajouter facilement un séparateur entre les livres grâce à separatorBuilder. On n'a donc pas besoin d'ajouter les séparateurs manuellement.

**Q2.7. Pourquoi utiliser un ListView horizontal pour les nouveautés ?**

Cela permet d'afficher les nouveautés côte à côte et de faire défiler les livres horizontalement. Chaque livre est affiché dans un Container de 110 pixels de largeur, avec sa couleur et son titre en blanc.

**Q2.8. Quelle erreur apparaît si le ListView vertical n'est pas dans Expanded ? Comment la corriger ?**

L'erreur peut être `Vertical viewport was given unbounded height`. Elle apparaît parce que le ListView n'a pas de hauteur limitée dans la Column. Pour corriger le problème, on utilise Expanded afin que la liste occupe l'espace restant sur l'écran.

**Q2.9. Quand utiliser shrinkWrap: true et NeverScrollableScrollPhysics() ?**

On peut utiliser ces propriétés lorsqu'une petite liste est placée dans une autre zone défilante. shrinkWrap adapte la hauteur de la liste à son contenu et NeverScrollableScrollPhysics désactive son propre défilement. Pour une grande liste, Expanded est généralement préférable.

## Partie 03 — CheckboxListTile

**Q3.1. Pourquoi un StatelessWidget ne suffit-il pas ?**

Parce que les cases à cocher changent d'état lorsque l'utilisateur clique dessus. StatefulWidget permet de gérer ces changements et de mettre à jour l'affichage.

**Q3.2. Que se passe-t-il si on oublie setState ?**

La valeur de la variable peut changer, mais l'interface ne se met pas automatiquement à jour. setState permet de demander à Flutter de réafficher les changements.

**Q3.3. Pourquoi utiliser Map<String, bool> pour les genres ?**

La Map permet d'associer chaque genre à une valeur true ou false selon qu'il est sélectionné ou non. On peut ensuite générer les cases à cocher automatiquement à partir des genres disponibles.

**Q3.4. À quoi servent secondary, subtitle et activeColor ?**

- `secondary` affiche une icône à côté du genre.
- `subtitle` affiche une information supplémentaire, comme le nombre de livres de ce genre.
- `activeColor` définit la couleur de la case lorsqu'elle est cochée.

**Q3.5. Quelle valeur de controlAffinity place la case à gauche ?**

`ListTileControlAffinity.leading` place la case à gauche, au début de la ligne. C'est cette valeur que je conserve pour mon interface.

**Q3.6. Comment fonctionne tristate: true ?**

Cette propriété permet d'avoir trois états : true si tous les genres sont cochés, false si aucun ne l'est et null si seulement certains sont cochés. La case « Tous les genres » permet ainsi de sélectionner ou de désélectionner tous les genres.

**Q3.7. Comment afficher les livres filtrés et barrer le titre des livres lus ?**

Je filtre les livres selon les genres sélectionnés, puis je les affiche avec ListView.separated. Pour les livres déjà lus, j'utilise TextDecoration.lineThrough afin de barrer leur titre. Pour les autres, je garde un texte normal.

**Q3.8. Comment afficher « Lus : X / Y » dans l'AppBar ?**

Je calcule le nombre de livres lus et le nombre total de livres affichés après le filtrage. J'utilise ces deux valeurs pour afficher le résultat dans l'AppBar, par exemple « Lus : 3 / 8 » si 3 livres sont lus sur les 8 affichés.
