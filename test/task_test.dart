import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

// Importez votre fichier main.dart
import 'package:projet/main.dart';

// Créez une classe de mock pour le client http
class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('Tests du widget TaskList', () {
    // Créez un client http mocké et transmettez-le à la fonction testWidgets
    MockHttpClient mockHttpClient = MockHttpClient();

    testWidgets('Le widget TaskList est rendu correctement', (WidgetTester tester) async {
      // Construisez le widget MyApp et déclenchez un rafraîchissement.
      await tester.pumpWidget(MyApp());

      // Vérifiez que le widget TaskList est rendu
      expect(find.byType(TaskList), findsOneWidget);

      // Vérifiez que les tâches initiales sont affichées correctement
      expect(find.text('Tâche 1'), findsOneWidget);
      expect(find.text('Tâche 2'), findsOneWidget);
      expect(find.text('Tâche 3'), findsOneWidget);
    });

    testWidgets('L\'ajout d\'une tâche met à jour TaskList', (WidgetTester tester) async {
      // Construisez le widget MyApp et déclenchez un rafraîchissement.
      await tester.pumpWidget(MyApp());

      // Appuyez sur le bouton 'Ajouter une tâche'
      await tester.tap(find.text('Ajouter une tâche'));
      await tester.pumpAndSettle(); // Attendez que la boîte de dialogue apparaisse

      // Entrez le texte de la nouvelle tâche et appuyez sur le bouton 'Ajouter'
      await tester.enterText(find.byType(TextField), 'Nouvelle tâche');
      await tester.tap(find.text('Ajouter'));
      await tester.pumpAndSettle(); // Attendez que la liste soit mise à jour

      // Vérifiez que la nouvelle tâche est ajoutée à la liste
      expect(find.text('Nouvelle tâche'), findsOneWidget);
    });

    testWidgets('La suppression d\'une tâche met à jour TaskList', (WidgetTester tester) async {
      // Construisez le widget MyApp et déclenchez un rafraîchissement.
      await tester.pumpWidget(MyApp());

      // Appuyez sur l'icône de suppression de 'Tâche 2'
      await tester.tap(find.widgetWithIcon(IconButton, Icons.delete).at(1));
      await tester.pumpAndSettle(); // Attendez que la liste soit mise à jour

      // Vérifiez que 'Tâche 2' est supprimée de la liste
      expect(find.text('Tâche 2'), findsNothing);
    });

    testWidgets('La modification d\'une tâche met à jour TaskList', (WidgetTester tester) async {
      // Construisez le widget MyApp et déclenchez un rafraîchissement.
      await tester.pumpWidget(MyApp());

      // Appuyez sur l'icône de modification de 'Tâche 3'
      await tester.tap(find.widgetWithIcon(IconButton, Icons.edit).at(2));
      await tester.pumpAndSettle(); // Attendez que la boîte de dialogue apparaisse

      // Entrez le texte de la tâche modifiée et appuyez sur le bouton 'Enregistrer'
      await tester.enterText(find.byType(TextField), 'Tâche modifiée');
      await tester.tap(find.text('Enregistrer'));
      await tester.pumpAndSettle(); // Attendez que la liste soit mise à jour

      // Vérifiez que 'Tâche 3' est mise à jour dans la liste
      expect(find.text('Tâche modifiée'), findsOneWidget);
    });

    // Ajoutez d'autres cas de test au besoin pour les autres fonctionnalités
  });
}
