import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/navigation/app_routes.dart';
import 'package:myportofolio_mobile/palette.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

enum PortfolioPage { home, education, projects, projectForm }

enum _DrawerDestination { home, addProject, education, authentication }

class PortfolioDrawer extends StatelessWidget {
  final PortfolioPage currentPage;

  const PortfolioDrawer({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;
    return Drawer(
      backgroundColor: PiratePalette.softPaper,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(22, 22, 18, 22),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [PiratePalette.deepNavy, PiratePalette.oceanBlue],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.explore_rounded,
                    color: PiratePalette.treasureGold,
                  ),
                  SizedBox(height: 14),
                  Text(
                    'NAVIGATION CHART',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Pilih tujuan pelayaranmu',
                    style: TextStyle(
                      color: PiratePalette.parchment,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _destinationTile(
              context,
              label: 'Home',
              icon: Icons.home_outlined,
              destination: _DrawerDestination.home,
              selected: currentPage == PortfolioPage.home,
            ),
            _destinationTile(
              context,
              label: 'Add Project',
              icon: Icons.add_box_outlined,
              destination: _DrawerDestination.addProject,
              selected: false,
            ),
            _destinationTile(
              context,
              label: 'Add Education',
              icon: Icons.school_outlined,
              destination: _DrawerDestination.education,
              selected: currentPage == PortfolioPage.education,
            ),
            _destinationTile(
              context,
              label: isLoggedIn ? 'Logout' : 'Login',
              icon: isLoggedIn ? Icons.logout_rounded : Icons.login_rounded,
              destination: _DrawerDestination.authentication,
              selected: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _destinationTile(
    BuildContext context, {
    required String label,
    required IconData icon,
    required _DrawerDestination destination,
    required bool selected,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: ListTile(
        selected: selected,
        selectedTileColor: PiratePalette.treasureGold.withValues(alpha: 0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        leading: Icon(icon),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        onTap: () => _handleDestination(context, destination),
      ),
    );
  }

  Future<void> _handleDestination(
    BuildContext context,
    _DrawerDestination destination,
  ) async {
    final navigator = Navigator.of(context);

    switch (destination) {
      case _DrawerDestination.home:
        navigator.popUntil((route) => route.isFirst);
        return;
      case _DrawerDestination.addProject:
        final authorized = await ensureLoggedIn(context);
        if (!context.mounted) return;
        navigator.pop();
        if (authorized) navigator.pushNamed(AppRoutes.projectForm);
        return;
      case _DrawerDestination.education:
        navigator.pop();
        if (currentPage != PortfolioPage.education) {
          navigator.pushNamed(AppRoutes.educationForm);
        }
        return;
      case _DrawerDestination.authentication:
        final authState = context.read<AuthState>();
        navigator.pop();
        if (authState.isLoggedIn) {
          await authState.logout();
          if (!context.mounted) return;
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Logged out.')));
        } else {
          await navigator.push<bool>(
            MaterialPageRoute<bool>(builder: (_) => const LoginScreen()),
          );
        }
        return;
    }
  }
}
