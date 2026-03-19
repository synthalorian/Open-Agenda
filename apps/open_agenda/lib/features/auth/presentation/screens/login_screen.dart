import 'package:flutter/material.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.neonGradient,
        ),
        child: Center(
          child: Text(
            'Login Screen - Coming Soon',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
