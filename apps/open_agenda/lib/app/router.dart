import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

import '../features/auth/presentation/screens/login_screen.dart';
import '../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../features/students/presentation/screens/students_screen.dart';
import '../features/students/presentation/screens/student_detail_screen.dart';
import '../features/students/presentation/screens/student_form_screen.dart';
import '../features/grades/presentation/screens/grades_screen.dart';
import '../features/grades/presentation/screens/assignment_detail_screen.dart';
import '../features/grades/presentation/screens/assignment_form_screen.dart';
import '../features/attendance/presentation/screens/attendance_screen.dart';
import '../features/attendance/presentation/screens/daily_attendance_screen.dart';
import '../features/planning/presentation/screens/planning_screen.dart';
import '../features/planning/presentation/screens/lesson_plan_detail_screen.dart';
import '../features/planning/presentation/screens/lesson_plan_form_screen.dart';
import '../features/iep/presentation/screens/iep_screen.dart';
import '../features/iep/presentation/screens/iep_goal_detail_screen.dart';
import '../features/iep/presentation/screens/iep_goal_form_screen.dart';
import '../features/settings/presentation/screens/settings_screen.dart';
import '../features/settings/presentation/screens/profile_edit_screen.dart';
import '../shared/presentation/widgets/main_shell.dart';

import 'auth_notifier.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.watch(authNotifierProvider);

  return GoRouter(
    refreshListenable: authNotifier,
    initialLocation: '/dashboard',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuthenticated = authNotifier.isAuthenticated;
      final isAuthRoute = state.matchedLocation == '/login';
      if (!isAuthenticated && !isAuthRoute) return '/login';
      if (isAuthenticated && isAuthRoute) return '/dashboard';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainShell(
          currentPath: state.matchedLocation,
          child: child,
        ),
        routes: [
          // Dashboard
          GoRoute(
            path: '/dashboard',
            name: 'dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),

          // Students
          GoRoute(
            path: '/students',
            name: 'students',
            builder: (context, state) => const StudentsScreen(),
            routes: [
              GoRoute(
                path: 'add',
                name: 'student-add',
                pageBuilder: (context, state) => neonTransitionPage(
                  state: state,
                  child: const StudentFormScreen(),
                ),
              ),
              GoRoute(
                path: ':id',
                name: 'student-detail',
                pageBuilder: (context, state) => neonTransitionPage(
                  state: state,
                  child: StudentDetailScreen(
                    studentId: state.pathParameters['id']!,
                  ),
                ),
                routes: [
                  GoRoute(
                    path: 'edit',
                    name: 'student-edit',
                    pageBuilder: (context, state) => neonTransitionPage(
                      state: state,
                      child: StudentFormScreen(
                        studentId: state.pathParameters['id'],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Grades
          GoRoute(
            path: '/grades',
            name: 'grades',
            builder: (context, state) => const GradesScreen(),
            routes: [
              GoRoute(
                path: 'assignment/add',
                name: 'assignment-add',
                pageBuilder: (context, state) => neonTransitionPage(
                  state: state,
                  child: const AssignmentFormScreen(),
                ),
              ),
              GoRoute(
                path: 'assignment/:id',
                name: 'assignment-detail',
                pageBuilder: (context, state) => neonTransitionPage(
                  state: state,
                  child: AssignmentDetailScreen(
                    assignmentId: state.pathParameters['id']!,
                  ),
                ),
              ),
            ],
          ),

          // Attendance
          GoRoute(
            path: '/attendance',
            name: 'attendance',
            builder: (context, state) => const AttendanceScreen(),
            routes: [
              GoRoute(
                path: 'take',
                name: 'take-attendance',
                pageBuilder: (context, state) {
                  final dateStr = state.uri.queryParameters['date'];
                  final date = dateStr != null
                      ? DateTime.tryParse(dateStr) ?? DateTime.now()
                      : DateTime.now();
                  return neonTransitionPage(
                    state: state,
                    child: DailyAttendanceScreen(date: date),
                  );
                },
              ),
            ],
          ),

          // Planning
          GoRoute(
            path: '/planning',
            name: 'planning',
            builder: (context, state) => const PlanningScreen(),
            routes: [
              GoRoute(
                path: 'add',
                name: 'plan-add',
                pageBuilder: (context, state) => neonTransitionPage(
                  state: state,
                  child: const LessonPlanFormScreen(),
                ),
              ),
              GoRoute(
                path: ':id',
                name: 'plan-detail',
                pageBuilder: (context, state) => neonTransitionPage(
                  state: state,
                  child: LessonPlanDetailScreen(
                    planId: state.pathParameters['id']!,
                  ),
                ),
                routes: [
                  GoRoute(
                    path: 'edit',
                    name: 'plan-edit',
                    pageBuilder: (context, state) => neonTransitionPage(
                      state: state,
                      child: const LessonPlanFormScreen(),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // IEP
          GoRoute(
            path: '/iep',
            name: 'iep',
            builder: (context, state) =>
                const IEPDashboardScreen(),
            routes: [
              GoRoute(
                path: 'add',
                name: 'iep-add',
                pageBuilder: (context, state) => neonTransitionPage(
                  state: state,
                  child: const IEPGoalFormScreen(),
                ),
              ),
              GoRoute(
                path: ':id',
                name: 'iep-detail',
                pageBuilder: (context, state) => neonTransitionPage(
                  state: state,
                  child: IEPGoalDetailScreen(
                    goalId: state.pathParameters['id']!,
                  ),
                ),
                routes: [
                  GoRoute(
                    path: 'edit',
                    name: 'iep-edit',
                    pageBuilder: (context, state) => neonTransitionPage(
                      state: state,
                      child: const IEPGoalFormScreen(),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Settings
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
            routes: [
              GoRoute(
                path: 'profile/edit',
                name: 'profile-edit',
                pageBuilder: (context, state) => neonTransitionPage(
                  state: state,
                  child: const ProfileEditScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline,
                size: 64, color: AppColors.error),
            const SizedBox(height: 16),
            Text('Page Not Found',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(
              state.error?.toString() ??
                  'The requested page does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/dashboard'),
              child: const Text('Go to Dashboard'),
            ),
          ],
        ),
      ),
    ),
  );
});

const List<NavigationDestination> bottomNavDestinations = [
  NavigationDestination(
    icon: Icon(Icons.dashboard_outlined),
    selectedIcon: Icon(Icons.dashboard),
    label: 'Dashboard',
  ),
  NavigationDestination(
    icon: Icon(Icons.people_outline),
    selectedIcon: Icon(Icons.people),
    label: 'Students',
  ),
  NavigationDestination(
    icon: Icon(Icons.grade_outlined),
    selectedIcon: Icon(Icons.grade),
    label: 'Grades',
  ),
  NavigationDestination(
    icon: Icon(Icons.event_note_outlined),
    selectedIcon: Icon(Icons.event_note),
    label: 'Attendance',
  ),
  NavigationDestination(
    icon: Icon(Icons.school_outlined),
    selectedIcon: Icon(Icons.school),
    label: 'IEP',
  ),
];

int getCurrentNavIndex(String path) {
  if (path.startsWith('/dashboard')) return 0;
  if (path.startsWith('/students')) return 1;
  if (path.startsWith('/grades')) return 2;
  if (path.startsWith('/attendance')) return 3;
  if (path.startsWith('/iep')) return 4;
  return 0;
}
