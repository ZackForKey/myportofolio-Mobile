import 'package:flutter/material.dart';

abstract final class PiratePalette {
  static const deepNavy = Color(0xFF0B1D33);
  static const oceanBlue = Color(0xFF145DA0);
  static const skyBlue = Color(0xFF3B82B8);
  static const treasureGold = Color(0xFFD6A84F);
  static const parchment = Color(0xFFF3E7CC);
  static const darkBrown = Color(0xFF68452C);
  static const softPaper = Color(0xFFFFFAF0);
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  const ItemHomepage({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static const String _npm = '2506657011';
  static const String _name = 'Mohammad Zaky Prastio';
  static const String _className = 'PBP C';

  static const List<ItemHomepage> _items = [
    ItemHomepage(
      name: 'Lihat Proyek',
      icon: Icons.travel_explore_rounded,
      color: PiratePalette.oceanBlue,
    ),
    ItemHomepage(
      name: 'Tambah Proyek',
      icon: Icons.add_circle_outline_rounded,
      color: PiratePalette.treasureGold,
    ),
    ItemHomepage(
      name: 'Logout',
      icon: Icons.logout_rounded,
      color: PiratePalette.darkBrown,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const Icon(Icons.sailing_rounded),
        title: const Text(
          'GRAND LINE JOURNAL',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.1,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [PiratePalette.softPaper, PiratePalette.parchment],
          ),
        ),
        child: SafeArea(
          top: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 720;

              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  isWide ? 32 : 18,
                  20,
                  isWide ? 32 : 18,
                  28,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: InfoCard(
                                title: 'NPM',
                                content: _npm,
                                icon: Icons.badge_outlined,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: InfoCard(
                                title: 'NAME',
                                content: _name,
                                icon: Icons.person_outline_rounded,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: InfoCard(
                                title: 'CLASS',
                                content: _className,
                                icon: Icons.groups_2_outlined,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        const _AdventureBanner(),
                        const SizedBox(height: 26),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Mission Board',
                                style: TextStyle(
                                  color: PiratePalette.deepNavy,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 11,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: PiratePalette.parchment,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: PiratePalette.treasureGold,
                                ),
                              ),
                              child: const Text(
                                '03 MISSIONS',
                                style: TextStyle(
                                  color: PiratePalette.darkBrown,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _items.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isWide ? 3 : 1,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 12,
                            mainAxisExtent: isWide ? 128 : 92,
                          ),
                          itemBuilder: (context, index) {
                            return ItemCard(_items[index]);
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'SAIL FAR  •  BUILD WITH PURPOSE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: PiratePalette.darkBrown,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;

  const InfoCard({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: PiratePalette.softPaper,
      elevation: 1,
      shadowColor: PiratePalette.deepNavy.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: PiratePalette.treasureGold.withValues(alpha: 0.55),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 11),
        child: Column(
          children: [
            Icon(icon, color: PiratePalette.oceanBlue, size: 18),
            const SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: PiratePalette.darkBrown,
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              content,
              textAlign: TextAlign.center,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.visible,
              style: const TextStyle(
                color: PiratePalette.deepNavy,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                height: 1.15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final foreground = _contrastingTextColor(item.color);

    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(20),
      elevation: 2,
      shadowColor: PiratePalette.deepNavy.withValues(alpha: 0.16),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Kamu telah menekan tombol ${item.name}!'),
                backgroundColor: PiratePalette.deepNavy,
                behavior: SnackBarBehavior.floating,
              ),
            );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: foreground.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(item.icon, color: foreground, size: 25),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: foreground,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Pilih untuk melanjutkan',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: foreground,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward_rounded, color: foreground, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _AdventureBanner extends StatelessWidget {
  const _AdventureBanner();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [PiratePalette.deepNavy, PiratePalette.oceanBlue],
          ),
        ),
        child: Stack(
          children: [
            const Positioned(
              right: -12,
              top: -20,
              child: Icon(
                Icons.explore_rounded,
                size: 148,
                color: Color(0x24FFFFFF),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0x1FFFFFFF),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0x40FFFFFF)),
                    ),
                    child: const Text(
                      'THE GRAND LINE  ·  PERSONAL PORTFOLIO',
                      style: TextStyle(
                        color: PiratePalette.parchment,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 17),
                  const Text(
                    'Selamat datang, Captain!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    'Jurnal proyek, ide, dan perjalanan belajar saya.',
                    style: TextStyle(
                      color: PiratePalette.parchment,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color _contrastingTextColor(Color backgroundColor) {
  const light = Colors.white;
  const dark = PiratePalette.deepNavy;
  final backgroundLuminance = backgroundColor.computeLuminance();
  final lightContrast = 1.05 / (backgroundLuminance + 0.05);
  final darkContrast = (backgroundLuminance + 0.05) /
      (dark.computeLuminance() + 0.05);

  return darkContrast >= lightContrast ? dark : light;
}
