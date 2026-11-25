import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/menu.dart';
import 'package:myportofolio_mobile/screens/education_form_page.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/screens/project_form_page.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  testWidgets('home keeps its profile cards and responsive action cards', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    for (final size in [const Size(320, 700), const Size(1024, 768)]) {
      tester.view.physicalSize = size;
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.byType(InfoCard), findsNWidgets(3));
      expect(find.text('2506657011'), findsOneWidget);
      expect(find.text('Mohammad Zaky Prastio'), findsOneWidget);
      expect(find.text('PBP C'), findsOneWidget);
      expect(find.byType(ItemCard), findsNWidgets(4));

      final colors = tester
          .widgetList<ItemCard>(find.byType(ItemCard))
          .map((card) => card.item.color)
          .toSet();
      expect(colors, hasLength(4));
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
    }
  });

  testWidgets('project, authentication, logout, and education actions work', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(_testApp());
    await tester.pumpAndSettle();

    final projectsCard = find.text('Lihat Proyek');
    await tester.ensureVisible(projectsCard);
    await tester.tap(projectsCard);
    await tester.pumpAndSettle();
    expect(find.byType(ProjectListScreen), findsOneWidget);
    expect(find.text('No projects found.'), findsOneWidget);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    final addProjectCard = find.text('Tambah Proyek');
    await tester.ensureVisible(addProjectCard);
    await tester.tap(addProjectCard);
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    final logoutCard = find.text('Logout');
    await tester.ensureVisible(logoutCard);
    await tester.tap(logoutCard);
    await tester.pumpAndSettle();
    expect(find.text('No active session.'), findsOneWidget);

    final educationCard = find.text('Tambah Pendidikan');
    await tester.ensureVisible(educationCard);
    await tester.tap(educationCard);
    await tester.pumpAndSettle();
    expect(find.byType(EducationFormPage), findsOneWidget);
  });

  testWidgets('drawer opens education form and form validates and summarizes', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 700);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(_testApp());
    await tester.pumpAndSettle();
    await _openDrawer(tester);
    await tester.tap(find.text('Add Education'));
    await tester.pumpAndSettle();
    expect(find.byType(EducationFormPage), findsOneWidget);
    expect(tester.takeException(), isNull);

    final saveButton = find.text('Simpan');
    await tester.ensureVisible(saveButton);
    await tester.tap(saveButton);
    await tester.pumpAndSettle();
    expect(find.text('Institution is required.'), findsOneWidget);
    expect(find.text('Program or major is required.'), findsOneWidget);
    expect(find.text('Please choose a degree level.'), findsOneWidget);
    expect(find.text('Graduation year is required.'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);

    await tester.enterText(find.byType(TextFormField).first, '   ');
    await tester.ensureVisible(saveButton);
    await tester.tap(saveButton);
    await tester.pumpAndSettle();
    expect(find.text('Institution is required.'), findsOneWidget);

    final yearField = find.byType(TextFormField).last;
    await tester.ensureVisible(yearField);
    await tester.enterText(yearField, '18');
    await tester.ensureVisible(saveButton);
    await tester.tap(saveButton);
    await tester.pumpAndSettle();
    expect(find.text('Enter the year using four digits.'), findsOneWidget);

    await tester.enterText(
      find.byType(TextFormField).first,
      'Universitas Indonesia',
    );
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Computer Science',
    );
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text("Bachelor's degree").last);
    await tester.pumpAndSettle();
    await tester.enterText(yearField, '2027');
    await tester.ensureVisible(saveButton);
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(
      find.textContaining('Institution: Universitas Indonesia'),
      findsOneWidget,
    );
    expect(
      find.textContaining('Program or major: Computer Science'),
      findsOneWidget,
    );
    expect(
      find.textContaining("Degree level: Bachelor's degree"),
      findsOneWidget,
    );
    expect(find.textContaining('Graduation year: 2027'), findsOneWidget);

    await tester.tap(find.text('Tutup'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(EducationFormPage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('project creation requests login and submits with its token', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(_testApp());
    await tester.pumpAndSettle();
    final addProject = find.text('Tambah Proyek');
    await tester.ensureVisible(addProject);
    await tester.tap(addProject);
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).first, 'captain');
    await tester.enterText(find.byType(TextFormField).last, 'secret');
    await tester.tap(find.widgetWithText(FilledButton, 'Login'));
    await tester.pumpAndSettle();
    expect(find.byType(ProjectFormPage), findsOneWidget);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Portfolio app');
    await tester.enterText(fields.at(1), 'A project portfolio.');
    await tester.enterText(fields.at(2), 'Flutter, Django');
    await tester.enterText(fields.at(3), 'https://example.com/project');
    await tester.tap(find.text('Save Project'));
    await tester.pumpAndSettle();

    expect(find.text('Project created'), findsOneWidget);
    expect(find.text('Test was added successfully.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('drawer Home and device back return to the home page', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    await _openEducationFromCard(tester);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byType(MyHomePage), findsOneWidget);
    expect(find.byType(EducationFormPage), findsNothing);

    await _openEducationFromCard(tester);
    await _openDrawer(tester);
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(find.byType(MyHomePage), findsOneWidget);
    expect(find.byType(EducationFormPage), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Add Project drawer option preserves its existing action', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    await _openEducationFromCard(tester);
    await _openDrawer(tester);
    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
  });
}

Widget _testApp() {
  final client = ApiClient(
    client: MockClient((request) async {
      if (request.method == 'GET' && request.url.path == '/api/v1/projects/') {
        return http.Response('[]', 200);
      }
      if (request.method == 'POST' &&
          request.url.path == '/api/v1/auth/token/') {
        return http.Response('{"token":"test-token"}', 200);
      }
      if (request.method == 'POST' &&
          request.url.path == '/api/v1/auth/logout/') {
        return http.Response('', 204);
      }
      if (request.method == 'POST' && request.url.path == '/api/v1/projects/') {
        return http.Response(
          '{"id":1,"title":"Test","description":"Test",'
          '"tech_stack":"Dart","project_url":"https://example.com",'
          '"project_image_url":""}',
          201,
        );
      }
      return http.Response('Not found', 404);
    }),
  );
  return MyApp.withApiClient(apiClient: client);
}

Future<void> _openDrawer(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.menu).first);
  await tester.pumpAndSettle();
}

Future<void> _openEducationFromCard(WidgetTester tester) async {
  final educationCard = find.text('Tambah Pendidikan');
  await tester.ensureVisible(educationCard);
  await tester.tap(educationCard);
  await tester.pumpAndSettle();
}
