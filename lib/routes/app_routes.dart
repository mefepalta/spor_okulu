import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/dashboard_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String dashboard = '/dashboard';

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const AppBootstrap(),
    dashboard: (context) => const DashboardScreen(),
  };
}
