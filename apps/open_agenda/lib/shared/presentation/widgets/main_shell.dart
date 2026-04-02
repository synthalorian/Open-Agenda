import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

import '../../../app/router.dart';

/// Main shell with bottom navigation
class MainShell extends StatelessWidget {
  final String currentPath;
  final Widget child;

  const MainShell({
    super.key,
    required this.currentPath,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final currentIndex = getCurrentNavIndex(currentPath);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              AppColors.darkBackground.withOpacity(0.95),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonPink.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: -5,
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            final routes = [
              '/dashboard',
              '/students',
              '/grades',
              '/attendance',
              '/iep',
            ];
            context.go(routes[index]);
          },
          destinations: bottomNavDestinations,
          backgroundColor: Colors.transparent,
          elevation: 0,
          height: 70,
          indicatorColor: AppColors.neonPink.withOpacity(0.15),
          surfaceTintColor: Colors.transparent,
        ),
      ),
      floatingActionButton: _buildFAB(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget? _buildFAB(BuildContext context) {
    if (currentPath.startsWith('/students')) {
      return _NeonFAB(
        icon: Icons.person_add,
        onPressed: () => context.push('/students/add'),
        tooltip: 'Add Student',
      );
    }

    if (currentPath.startsWith('/grades')) {
      return _NeonFAB(
        icon: Icons.add_chart,
        onPressed: () => context.push('/grades/assignment/add'),
        tooltip: 'Add Assignment',
      );
    }

    if (currentPath.startsWith('/attendance')) {
      return _NeonFAB(
        icon: Icons.fact_check,
        onPressed: () => context.push('/attendance/take'),
        tooltip: 'Take Attendance',
      );
    }

    if (currentPath.startsWith('/planning')) {
      return _NeonFAB(
        icon: Icons.add_task,
        onPressed: () => context.push('/planning/add'),
        tooltip: 'Add Lesson Plan',
      );
    }

    if (currentPath.startsWith('/iep')) {
      return _NeonFAB(
        icon: Icons.playlist_add,
        onPressed: () => context.push('/iep/add'),
        tooltip: 'Add IEP Goal',
      );
    }

    return null;
  }
}

/// Neon-styled floating action button
class _NeonFAB extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;

  const _NeonFAB({
    required this.icon,
    this.onPressed,
    required this.tooltip,
  });

  @override
  State<_NeonFAB> createState() => _NeonFABState();
}

class _NeonFABState extends State<_NeonFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _glowAnimation = Tween<double>(begin: 8.0, end: 16.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          return Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  AppColors.neonPink,
                  AppColors.neonPurple,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.neonPink.withOpacity(_isHovered ? 0.7 : 0.5),
                  blurRadius: _glowAnimation.value,
                  spreadRadius: _isHovered ? 2 : 0,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: Tooltip(
                message: widget.tooltip,
                child: InkWell(
                  onTap: widget.onPressed,
                  customBorder: const CircleBorder(),
                  child: Icon(
                    widget.icon,
                    color: AppColors.textPrimary,
                    size: 28,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
