import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:projet/main.dart';


class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('Tests du widget TaskList', () {
    MockHttpClient mockHttpClient = MockHttpClient();

    testWidgets('Le widget TaskList est rendu correctement', (WidgetTester tester) async {
      // Construit le widget MyApp et déclenche un rafraîchissement.
      await tester.pumpWidget(MyApp());

      // Vérifie que le widget TaskList est rendu
      expect(find.byType(TaskList), findsOneWidget);

      // Vérifie que les tâches initiales sont affichées correctement
      expect(find.text('Tâche 1'), findsOneWidget);
      expect(find.text('Tâche 2'), findsOneWidget);
      expect(find.text('Tâche 3'), findsOneWidget);
    });

    testWidgets('L\'ajout d\'une tâche met à jour TaskList', (WidgetTester tester) async {
      // Construit le widget MyApp et déclenche un rafraîchissement.
      await tester.pumpWidget(MyApp());

      // Appuyez sur le bouton 'Ajouter une tâche'
      await tester.tap(find.text('Ajouter une tâche'));
      await tester.pumpAndSettle(); // Attend que la boîte de dialogue apparaisse

      // Entrez le texte de la nouvelle tâche et appuie sur le bouton 'Ajouter'
      await tester.enterText(find.byType(TextField), 'Nouvelle tâche');
      await tester.tap(find.text('Ajouter'));
      await tester.pumpAndSettle(); // Attend que la liste soit mise à jour

      // Vérifie que la nouvelle tâche est ajoutée à la liste
      expect(find.text('Nouvelle tâche'), findsOneWidget);
    });

    testWidgets('La suppression d\'une tâche met à jour TaskList', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      // Appuie sur l'icône de suppression de 'Tâche 2'
      await tester.tap(find.widgetWithIcon(IconButton, Icons.delete).at(1));
      await tester.pumpAndSettle(); // Attendez que la liste soit mise à jour

      // Vérifiez que 'Tâche 2' est supprimée de la liste
      expect(find.text('Tâche 2'), findsNothing);
    });

    testWidgets('La modification d\'une tâche met à jour TaskList', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      // Appuie sur l'icône de modification de 'Tâche 3'
      await tester.tap(find.widgetWithIcon(IconButton, Icons.edit).at(2));
      await tester.pumpAndSettle(); // Attendez que la boîte de dialogue apparaisse

      // Entre le texte de la tâche modifiée et appuyez sur le bouton 'Enregistrer'
      await tester.enterText(find.byType(TextField), 'Tâche modifiée');
      await tester.tap(find.text('Enregistrer'));
      await tester.pumpAndSettle(); // Attend que la liste soit mise à jour

      // Vérifiez que 'Tâche 3' est mise à jour dans la liste
      expect(find.text('Tâche modifiée'), findsOneWidget);
    });

  });
}
