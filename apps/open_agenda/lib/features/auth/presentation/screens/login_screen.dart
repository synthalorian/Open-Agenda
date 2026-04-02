import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

import '../../../../app/auth_notifier.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String _pin = '';
  bool _pinRequired = false;
  bool _loading = true;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _checkPinStatus();
  }

  Future<void> _checkPinStatus() async {
    final auth = ref.read(authNotifierProvider);
    final pinEnabled = await auth.isPinEnabled();
    setState(() {
      _pinRequired = pinEnabled;
      _loading = false;
    });
  }

  void _onDigit(String digit) {
    if (_pin.length >= 6) return;
    setState(() {
      _pin += digit;
      _error = false;
    });
    if (_pin.length == 4) {
      _verifyPin();
    }
  }

  void _onBackspace() {
    if (_pin.isEmpty) return;
    setState(() {
      _pin = _pin.substring(0, _pin.length - 1);
      _error = false;
    });
  }

  Future<void> _verifyPin() async {
    final auth = ref.read(authNotifierProvider);
    final success = await auth.verifyPin(_pin);
    if (!success) {
      setState(() {
        _error = true;
        _pin = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.darkBackground,
              Color(0xFF1A0A2E),
              AppColors.darkBackground,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: _loading
                ? const CircularProgressIndicator(
                    color: AppColors.neonPurple)
                : _pinRequired
                    ? _buildPinEntry(context)
                    : _buildGetStarted(context),
          ),
        ),
      ),
    );
  }

  Widget _buildGetStarted(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.school,
              size: 80,
              color: AppColors.neonPurple.withOpacity(0.8)),
          const SizedBox(height: 24),
          Text(
            'Open Agenda',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  foreground: Paint()
                    ..shader = AppColors.neonGradient.createShader(
                      const Rect.fromLTWH(0, 0, 250, 50),
                    ),
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'K-12 Educational Management',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 48),
          NeonButton(
            text: 'Get Started',
            onPressed: () =>
                ref.read(authNotifierProvider).login(),
          ),
        ],
      ),
    );
  }

  Widget _buildPinEntry(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lock_outline,
              size: 48, color: AppColors.neonPurple),
          const SizedBox(height: 16),
          Text(
            'Enter PIN',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 24),

          // PIN dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (i) {
              final filled = i < _pin.length;
              return Container(
                width: 16,
                height: 16,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: filled
                      ? (_error
                          ? AppColors.neonPink
                          : AppColors.neonPurple)
                      : Colors.transparent,
                  border: Border.all(
                    color: _error
                        ? AppColors.neonPink
                        : AppColors.neonPurple,
                    width: 2,
                  ),
                ),
              );
            }),
          ),
          if (_error) ...[
            const SizedBox(height: 12),
            Text(
              'Incorrect PIN',
              style: TextStyle(
                  color: AppColors.neonPink, fontSize: 14),
            ),
          ],
          const SizedBox(height: 32),

          // Number pad
          SizedBox(
            width: 260,
            child: Column(
              children: [
                for (final row in [
                  ['1', '2', '3'],
                  ['4', '5', '6'],
                  ['7', '8', '9'],
                  ['', '0', '⌫'],
                ])
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                    children: row.map((key) {
                      if (key.isEmpty) {
                        return const SizedBox(width: 72, height: 72);
                      }
                      if (key == '⌫') {
                        return _PadButton(
                          child: const Icon(Icons.backspace_outlined,
                              size: 22),
                          onTap: _onBackspace,
                        );
                      }
                      return _PadButton(
                        child: Text(key,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600)),
                        onTap: () => _onDigit(key),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PadButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const _PadButton({required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Material(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(36),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(36),
          child: SizedBox(
            width: 72,
            height: 72,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
