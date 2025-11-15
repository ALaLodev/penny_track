import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/gastos/presentation/pages/lista_gastos_page.dart';
import '../../features/gastos/presentation/pages/nuevo_gasto_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String nuevoGasto = '/nuevo-gasto';
}

final appRouter = GoRouter(
  // Opcional: Útil para depuración
  //debugLogDiagnostics: true,
  initialLocation: AppRoutes.home,

  routes: [
    // Ruta Principal (Home)
    GoRoute(
      path: AppRoutes.home,
      builder: (BuildContext context, GoRouterState state) {
        // Esta es la página que ya creamos
        return const ListaGastosPage();
      },
    ),

    // Ruta para "Añadir Gasto" (la usaremos desde el FAB)
    GoRoute(
      path: AppRoutes.nuevoGasto,
      builder: (BuildContext context, GoRouterState state) {
        return const NuevoGastoPage();
      },
    ),
  ],
);
