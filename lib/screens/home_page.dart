import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/palette.dart';
import 'package:myportofolio_mobile/navigation/app_routes.dart';
import 'package:myportofolio_mobile/screens/education_form_page.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/info_card.dart';
import 'package:myportofolio_mobile/widgets/portfolio_drawer.dart';
import 'package:myportofolio_mobile/widgets/portfolio_item_card.dart';
import 'package:provider/provider.dart';

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
    ItemHomepage(
      name: 'Tambah Pendidikan',
      icon: Icons.school_rounded,
      color: PiratePalette.seaGlass,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const PortfolioDrawer(currentPage: PortfolioPage.home),
      appBar: AppBar(
        title: const Text(
          'GRAND LINE JOURNAL',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.1,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.sailing_rounded),
          ),
        ],
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
              final columns = constraints.maxWidth >= 960
                  ? 4
                  : constraints.maxWidth >= 640
                  ? 2
                  : 1;

              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  constraints.maxWidth >= 720 ? 32 : 18,
                  20,
                  constraints.maxWidth >= 720 ? 32 : 18,
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
                                '04 MISSIONS',
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
                                crossAxisCount: columns,
                                crossAxisSpacing: 14,
                                mainAxisSpacing: 12,
                                mainAxisExtent: columns == 1 ? 92 : 120,
                              ),
                          itemBuilder: (context, index) {
                            final item = _items[index];
                            return ItemCard(
                              item,
                              onTap: () => _handleMission(context, index),
                            );
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

  Future<void> _handleMission(BuildContext context, int index) async {
    switch (index) {
      case 0:
        await Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const ProjectListScreen(),
          ),
        );
        return;
      case 1:
        if (await ensureLoggedIn(context) && context.mounted) {
          await Navigator.of(context).pushNamed(AppRoutes.projectForm);
        }
        return;
      case 2:
        final authState = context.read<AuthState>();
        final wasLoggedIn = authState.isLoggedIn;
        if (wasLoggedIn) {
          await authState.logout();
        }
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(wasLoggedIn ? 'Logged out.' : 'No active session.'),
            backgroundColor: PiratePalette.deepNavy,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      case 3:
        await Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const EducationFormPage(),
          ),
        );
        return;
    }
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
