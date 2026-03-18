// lib/App/TomobilApp.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Auth/Login/LoginView.dart';
import '../Auth/NewPassword/NewPasswordView.dart';

import '../Dashboard/Dashboard/DashboardView.dart';
import '../init/Manager.dart';
import '../Router/route_observer.dart';

class TomobilApp extends StatefulWidget {
  const TomobilApp({super.key, required this.manager});
  final Manager manager;

  @override
  State<TomobilApp> createState() => _TomobilAppState();
}

class _TomobilAppState extends State<TomobilApp> {
  late final GoRouter _router = GoRouter(
    debugLogDiagnostics: false,
    observers: [routeObserver],
    errorBuilder: (context, state) => LoginView(manager: widget.manager),
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => SplashScreen(manager: widget.manager),
      ),

      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => LoginView(manager: widget.manager),
      ),

      // -------- Dashboard shell (admin only page inside dashboard) --------
      ShellRoute(
        builder: (context, state, child) =>
            AppShell(manager: widget.manager, child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            name: 'dashboard_root',
            redirect: (_, __) => '/dashboard/admin',
          ),
          GoRoute(
            path: '/dashboard/admin',
            name: 'dashboard_admin',
            builder: (context, state) => DashboardView(
              manager: widget.manager,
              initialPath: state.matchedLocation,
            ),
          ),
        ],
      ),

      GoRoute(
        path: '/reset-password',
        name: 'reset_password',
        builder: (context, state) {
          final uri = state.uri;

          final hostOk = uri.host.isEmpty || uri.host == 'winycar.com';
          final pathOk = uri.path == '/reset-password';
          if (!hostOk || !pathOk) {
            return LoginView(manager: widget.manager);
          }

          final qp = uri.queryParameters;
          final email = qp['email'] ?? '';
          final token = qp['token'] ?? '';
          if (email.isEmpty || token.isEmpty) {
            return LoginView(manager: widget.manager);
          }

          return NewPasswordView(
            manager: widget.manager,
            email: Uri.decodeComponent(email),
            token: token,
          );
        },
      ),
    ],
    redirect: (context, state) {
      final loc = state.matchedLocation;
      final isLoggedIn = widget.manager.isAuthenticated;

      final isAuthRoute = loc == '/login' || loc == '/signup';
      final isProtected = loc.startsWith('/dashboard');

      if (!isLoggedIn && isProtected) return '/login';

      if (isLoggedIn && isAuthRoute) return '/dashboard/admin';

      if (isLoggedIn && loc == '/dashboard') return '/dashboard/admin';

      return null;
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'Tomobil',
      theme: ThemeData(useMaterial3: false),
    );
  }
}

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.manager, required this.child});
  final Manager manager;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {},
      child: Scaffold(body: child),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.manager});
  final Manager manager;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    if (!mounted) return;

    final start =
    widget.manager.isAuthenticated ? '/dashboard/admin' : '/login';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.go(start);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
