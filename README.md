# projet

Ce projet est une application Flutter qui permet de gérer une liste de tâches. L'utilisateur peut voir la liste des tâches existantes, ajouter de nouvelles tâches, supprimer des tâches et marquer des tâches comme terminées. Lorsqu'une tâche est marquée comme terminée, l'application affiche une blague de Chuck Norris en guise de "félicitation". L'application utilise l'API "Chuck Norris Jokes" (https://api.chucknorris.io) pour récupérer les blagues de Chuck Norris à afficher lorsque les tâches sont terminées.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## justification des choix 

Dans le code que j'ai fourni, j'ai utilisé StatefulWidget (_TaskListState) car nous voulons gérer l'état des tâches (par exemple, les tâches complétées) et que certaines parties de l'interface utilisateur doivent être mises à jour en réponse aux changements d'état (par exemple, lorsque nous cochons une case pour marquer une tâche comme terminée).

J'ai également utilisé StatefulWidget pour la classe AddTaskForm, car nous voulons gérer l'état du champ de texte où l'utilisateur entre de nouvelles tâches. Lorsque nous appuyons sur le bouton "Ajouter", l'état du champ de texte doit être réinitialisé (effacer le texte entré) pour permettre à l'utilisateur d'entrer une nouvelle tâche.

En résumé, nous utilisons StatefulWidget lorsque nous avons besoin de gérer l'état de notre application et que certaines parties de l'interface utilisateur doivent être mises à jour en réponse aux changements d'état. Si une partie de l'interface utilisateur ne change pas ou n'a pas besoin d'être redessinée en réponse aux changements d'état, nous pouvons utiliser StatelessWidget.
