import 'package:go_router/go_router.dart';
import 'package:penny_track/features/auth/presentation/pages/login_page.dart';
import 'package:penny_track/features/auth/presentation/pages/register_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/gastos/presentation/pages/nuevo_gasto_page.dart';
import '../../features/ingresos/presentation/pages/nuevo_ingreso_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String nuevoGasto = '/nuevo-gasto';
  static const String nuevoIngreso = '/nuevo-ingreso';
}

final appRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: AppRoutes.nuevoGasto,
      builder: (context, state) => const NuevoGastoPage(),
    ),
    GoRoute(
      path: AppRoutes.nuevoIngreso,
      builder: (context, state) => const NuevoIngresoPage(),
    ),
  ],
);
