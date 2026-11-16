import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/menu.dart';

void main() {
  testWidgets('shows the three info cards and responsive mission cards', (
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
      expect(find.byType(ItemCard), findsNWidgets(3));

      final colors = tester
          .widgetList<ItemCard>(find.byType(ItemCard))
          .map((card) => card.item.color)
          .toSet();
      expect(colors, hasLength(3));
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
    }
  });

  testWidgets('each mission card displays its required SnackBar', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    const labels = ['Lihat Proyek', 'Tambah Proyek', 'Logout'];
    for (final label in labels) {
      final cardLabel = find.text(label);
      await tester.ensureVisible(cardLabel);
      await tester.tap(cardLabel);
      await tester.pumpAndSettle();
      expect(
        find.text('Kamu telah menekan tombol $label!'),
        findsOneWidget,
      );
    }
  });
}
