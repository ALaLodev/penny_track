import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/gastos/presentation/pages/lista_gastos_page.dart';
import '../../features/gastos/presentation/pages/nuevo_gasto_page.dart';
import '../../features/ingresos/presentation/pages/lista_ingresos_page.dart';
import '../../features/ingresos/presentation/pages/nuevo_ingreso_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String nuevoGasto = '/nuevo-gasto';
  static const String ingresos = '/ingresos';
  static const String nuevoIngreso = '/nuevo-ingreso';
}

final appRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: AppRoutes.home,
  routes: [
    // --- Rutas de Gastos ---
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const ListaGastosPage(),
    ),
    GoRoute(
      path: AppRoutes.nuevoGasto,
      builder: (context, state) => const NuevoGastoPage(),
    ),

    // --- Rutas de Ingresos ---
    GoRoute(
      path: AppRoutes.ingresos,
      builder: (context, state) => const ListaIngresosPage(),
    ),
    GoRoute(
      path: AppRoutes.nuevoIngreso,
      builder: (context, state) => const NuevoIngresoPage(),
    ),
  ],
);
