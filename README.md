# Consigne

Faire une application Flutter qui utilise une API 

# Description du projet

Ce projet est une application Flutter qui permet de gérer une liste de tâches. L'utilisateur peut voir la liste des tâches existantes, ajouter de nouvelles tâches, supprimer des tâches et marquer des tâches comme terminées. Lorsqu'une tâche est marquée comme terminée, l'application affiche une blague de Chuck Norris en guise de "félicitation". L'application utilise l'API "Chuck Norris Jokes" (https://api.chucknorris.io) pour récupérer les blagues de Chuck Norris à afficher lorsque les tâches sont terminées.

## Exemple de réponse de l'API


```
{
"icon_url" : "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
"id" : "he6TQwBBTDK-LHIEjO79oQ",
"url" : "",
"value" : "How many roads must a man walk down, before you can call him a man? Don't ask Chuck Norris, he was considered a man by age four."
}
```


## Lancement de ce projet

`flutter pub get` 

puis 

`flutter run`

## Lancement du test de ce projet 

`flutter test`

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## justification des choix 

**Gestion de l'état** : Pour la gestion de l'état, j'ai choisi d'utiliser StatefulWidget car le projet est relativement simple et ne nécessite pas une gestion complexe de l'état. StatefulWidget offre une solution simple et efficace pour mettre à jour l'interface utilisateur en fonction des changements d'état. Pour des applications plus complexes, d'autres solutions comme Provider ou Riverpod pourraient être envisagées pour une gestion plus avancée de l'état.

**Gestion de la navigation** : Pour la gestion de la navigation, j'ai opté pour l'utilisation des fonctions Navigator.push et Navigator.pop car elles sont simples et directes à utiliser. Dans ce projet, nous avons seulement besoin de naviguer entre deux écrans, et ces fonctions fournissent une solution suffisamment élégante pour cette tâche. Cependant, pour des applications plus grandes avec des routes plus complexes, des packages de gestion de la navigation tels que flutter_bloc ou routemaster pourraient être envisagés pour une gestion plus avancée de la navigation.

**API de blagues** : J'ai choisi l'API Chuck Norris pour fournir des blagues lorsqu'une tâche est cochée. L'API est simple à utiliser et fournit peu de données. Si nécessaire, d'autres API de blagues ou de données pourraient être facilement intégrées à la place pour offrir une plus grande variété de contenu.

**Design et mise en page** : Le projet utilise une mise en page simple avec une liste de tache et des boutons de modification, d'ajout et de suppression. Des améliorations supplémentaires pourraient être apportées au design en utilisant des packages de conception tels que flutter_bloc ou en personnalisant davantage les widgets pour une interface plus esthétique et personnalisée.

**Gestion des erreurs** : Pour la gestion des erreurs, j'ai choisi d'afficher une boîte de dialogue lorsque la récupération des blagues Chuck Norris échoue. Cela permet d'informer l'utilisateur de manière claire et concise sur l'erreur survenue. Pour des applications plus complexes, des méthodes de gestion des erreurs plus avancées pourraient être mises en place, telles que l'affichage de messages d'erreur en bas de l'écran ou l'utilisation de packages de gestion d'erreurs.

**Tests unitaires et tests d'intégration** : J'ai ajouté un test unitaire pour la fonction _toggleTaskCompletion pour vérifier le bon fonctionnement de la gestion de l'état de complétion des tâches. Dans un contexte de développement plus avancé, d'autres tests unitaires pourraient être ajoutés pour couvrir davantage de cas d'utilisation et assurer la stabilité de l'application.

En conclusion, les choix effectués dans ce projet ont été faits en gardant à l'esprit la simplicité et l'efficacité de l'application.
