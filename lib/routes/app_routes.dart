import 'package:flutter/material.dart';

import '../screens/auth_gate.dart';
import '../screens/dashboard_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String dashboard = '/dashboard';

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const AuthGate(),
    dashboard: (context) => const DashboardScreen(),
  };
}
