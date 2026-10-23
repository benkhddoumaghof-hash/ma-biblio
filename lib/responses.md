# Réponses aux questions de réflexion — TP Flutter MaBiblio

## Partie 01 — Le widget ListTile

### Question 1 : Quelle est la différence entre `leading` et `trailing` ?

- `leading` affiche un élément au début du `ListTile`, généralement à gauche, comme une icône ou une image.
- `trailing` affiche un élément à la fin du `ListTile`, généralement à droite, comme une flèche ou une case à cocher.

### Question 2 : Pourquoi un `ListTile` doit-il être placé dans un parent à largeur contrainte ?

Le `ListTile` a besoin d'une largeur définie pour organiser correctement son titre, son sous-titre et ses icônes. Un parent à largeur contrainte, comme `Container`, `SizedBox` ou `Expanded`, permet à Flutter de calculer correctement sa mise en page.

## Partie 02 — Le widget ListView

### Q2.1. Quel message d'erreur apparaît en mode paysage ou avec 10 ListTile supplémentaires ? Expliquer pourquoi.

L'erreur affichée est généralement `A RenderFlex overflowed by ... pixels on the bottom`, représentée par une bande jaune et noire.

Elle apparaît parce que la `Column` contient plus d'éléments que l'écran ne peut en afficher verticalement. La hauteur disponible est insuffisante et les éléments dépassent les limites de l'écran.

### Q2.2. Pourquoi remplacer la Column par un ListView ?

`ListView` permet de faire défiler les éléments verticalement lorsque leur hauteur totale dépasse celle de l'écran. Le `padding: EdgeInsets.all(8)` ajoute une marge intérieure de 8 pixels autour de la liste.

### Q2.3. Quel est l'avantage de ListTile.divideTiles() ?

`ListTile.divideTiles()` ajoute automatiquement des séparateurs entre les `ListTile`. Cette solution évite d'insérer manuellement un `Divider()` entre chaque élément et rend le code plus simple à maintenir.

### Q2.4. Quel est le rôle de ListView.builder ?

`ListView.builder` construit les éléments de la liste à la demande grâce à `itemCount` et `itemBuilder`. Il permet de parcourir la liste des livres et de réutiliser la fonction `livreTile()` pour afficher chaque livre.

### Q2.5. Pourquoi ListView.builder est-il préférable pour une liste de 1 000 livres ?

`ListView.builder` construit principalement les éléments visibles à l'écran, au fur et à mesure du défilement. Il réduit ainsi le travail initial et la consommation de ressources par rapport à `ListView(children: ...)`, qui reçoit une liste d'éléments déjà construits.

### Q2.6. Quel est l'intérêt de ListView.separated ?

`ListView.separated` permet de définir séparément la construction des éléments avec `itemBuilder` et celle des séparateurs avec `separatorBuilder`. Il facilite l'ajout de séparateurs entre les livres sans devoir les insérer manuellement.

### Q2.7. Pourquoi utiliser un ListView horizontal pour les nouveautés ?

`scrollDirection: Axis.horizontal` permet de faire défiler les nouveautés horizontalement. Chaque livre est affiché dans un `Container` de 110 pixels de largeur, avec la couleur du livre et son titre centré en blanc. Un `SizedBox` de 160 pixels de hauteur réserve l'espace nécessaire à cette liste.

### Q2.8. Quelle erreur apparaît si le ListView vertical n'est pas dans un Expanded ? Comment la corriger ?

Flutter peut afficher l'erreur `Vertical viewport was given unbounded height`.

Cette erreur apparaît parce que le `ListView` vertical placé dans une `Column` ne reçoit pas de hauteur maximale définie. Il faut le placer dans un `Expanded` pour qu'il occupe l'espace restant disponible.

### Q2.9. Dans quel cas utiliser shrinkWrap: true avec NeverScrollableScrollPhysics() ?

Cette solution est utile lorsqu'une petite liste doit être intégrée dans une autre zone défilante, par exemple dans une `SingleChildScrollView`.

- `shrinkWrap: true` adapte la hauteur de la liste à son contenu.
- `NeverScrollableScrollPhysics()` désactive le défilement propre de cette liste.

Pour une grande liste de 1 000 livres, il est généralement préférable d'utiliser `Expanded` avec une liste défilante, car `shrinkWrap: true` peut augmenter le coût de mise en page.

## Partie 03 — Le widget CheckboxListTile

### Q3.1. Pourquoi un StatelessWidget ne suffit-il pas ici ?

Un `StatelessWidget` ne gère pas directement un état modifiable. Comme les cases à cocher doivent changer lorsque l'utilisateur interagit avec elles, un `StatefulWidget` est nécessaire pour conserver et mettre à jour leur état.

### Q3.2. Que se passe-t-il si on oublie setState() ?

La variable peut changer sans que l'interface soit reconstruite. La case à cocher risque donc de ne pas refléter visuellement la nouvelle valeur. `setState()` demande à Flutter de reconstruire l'interface pour afficher la modification.

### Q3.3. Pourquoi utiliser Map<String, bool> pour les genres ?

La `Map<String, bool>` associe chaque genre à une valeur booléenne indiquant s'il est sélectionné. Elle facilite la gestion des filtres et permet de générer automatiquement les cases à cocher avec `_genres.keys.map(...)`.

### Q3.4. À quoi servent secondary, subtitle et activeColor ?

- `secondary` affiche une icône adaptée au genre.
- `subtitle` affiche une information complémentaire, ici le nombre de livres appartenant à ce genre.
- `activeColor` définit la couleur de la case lorsqu'elle est cochée.

### Q3.5. Quelle valeur de controlAffinity place la case à gauche ?

`ListTileControlAffinity.leading` place la case à cocher au début de la ligne, généralement à gauche dans une interface en français.

`ListTileControlAffinity.trailing` la place à la fin de la ligne, tandis que `ListTileControlAffinity.platform` adapte sa position au comportement prévu pour la plateforme.

### Q3.6. Comment fonctionne tristate: true pour « Tous les genres » ?

Avec `tristate: true`, la case à cocher peut avoir trois états :

- `true` : tous les genres sont sélectionnés.
- `false` : aucun genre n'est sélectionné.
- `null` : certains genres sont sélectionnés, mais pas tous.

Un clic sur cette case permet de sélectionner ou de désélectionner tous les genres selon la logique définie dans `onChanged`.

### Q3.7. Comment afficher les livres filtrés et barrer le titre des livres lus ?

`ListView.separated` permet d'afficher uniquement les livres correspondant aux genres sélectionnés. Chaque livre est représenté par un `CheckboxListTile` dont la propriété `value` correspond à `livre.lu`.

Pour barrer le titre d'un livre lu, on utilise `TextDecoration.lineThrough`. Si le livre n'est pas lu, on utilise `TextDecoration.none`.

### Q3.8. Comment afficher « Lus : X / Y » dans l'AppBar ?

- `X` représente le nombre de livres lus parmi les livres affichés.
- `Y` représente le nombre total de livres affichés après application des filtres.

Ces valeurs peuvent être calculées avec `where()` et `length`, puis affichées dynamiquement dans le titre de l'`AppBar`. Par exemple, si 3 livres sont lus parmi 8 livres affichés, le titre sera « Lus : 3 / 8 ».
