import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

Future<bool> ensureLoggedIn(BuildContext context) async {
  final authState = context.read<AuthState>();
  final navigator = Navigator.of(context);
  if (authState.isLoggedIn) return true;

  final loggedIn = await navigator.push<bool>(
    MaterialPageRoute<bool>(builder: (_) => const LoginScreen()),
  );
  return loggedIn == true || authState.isLoggedIn;
}
