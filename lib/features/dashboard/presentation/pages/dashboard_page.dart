import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:penny_track/core/config/router.dart';

// Imports de features
import 'package:penny_track/features/gastos/presentation/cubits/lista_gastos_cubit.dart';
import 'package:penny_track/features/gastos/presentation/cubits/lista_gastos_state.dart';
import 'package:penny_track/features/ingresos/presentation/cubits/lista_ingresos_cubit.dart';
import 'package:penny_track/features/ingresos/presentation/cubits/lista_ingresos_state.dart';
import 'package:penny_track/features/gastos/presentation/widgets/lista_gastos_view.dart';
import 'package:penny_track/features/ingresos/presentation/widgets/lista_ingresos_view.dart';
import 'package:penny_track/features/auth/presentation/cubits/auth_cubit.dart';

enum TipoVista { gastos, ingresos }

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  TipoVista _vistaActual = TipoVista.gastos;

  void _onFabPressed() {
    if (_vistaActual == TipoVista.gastos) {
      context.push(AppRoutes.nuevoGasto);
    } else {
      context.push(AppRoutes.nuevoIngreso);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Data providers
    final gastosState = context.watch<ListaGastosCubit>().state;
    final ingresosState = context.watch<ListaIngresosCubit>().state;

    // ENVOLVEMOS EL SCAFFOLD CON BLOCLISTENER
    // Esto es crucial: escucha si el usuario se desconecta para echarlo al login
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          // Si el estado cambia a "No autenticado", vamos al Login
          context.go(AppRoutes.login);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mis Movimientos'),
          // Logout
          actions: [
            IconButton(
              icon: const Icon(Icons.logout_rounded),
              tooltip: 'Cerrar Sesión',
              onPressed: () {
                // Muestra diálogo de confirmación
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('¿Cerrar sesión?'),
                    content: const Text(
                      'Tendrás que volver a ingresar tus datos.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context), // Cancelar
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Cierra el  diálogo
                          // Llamar al logout del Cubit
                          context.read<AuthCubit>().logout();
                        },
                        child: Text(
                          'Salir',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SegmentedButton<TipoVista>(
                segments: const [
                  ButtonSegment(
                    value: TipoVista.gastos,
                    label: Text('Gastos'),
                    icon: Icon(Icons.arrow_downward),
                  ),
                  ButtonSegment(
                    value: TipoVista.ingresos,
                    label: Text('Ingresos'),
                    icon: Icon(Icons.arrow_upward),
                  ),
                ],
                selected: {_vistaActual},
                onSelectionChanged: (Set<TipoVista> newSelection) {
                  setState(() {
                    _vistaActual = newSelection.first;
                  });
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onFabPressed,
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            _BalanceSummaryView(
              gastosState: gastosState,
              ingresosState: ingresosState,
            ),
            Expanded(
              child: _vistaActual == TipoVista.gastos
                  ? const ListaGastosView()
                  : const ListaIngresosView(),
            ),
          ],
        ),
      ),
    );
  }
}

class _BalanceSummaryView extends StatelessWidget {
  final ListaGastosState gastosState;
  final ListaIngresosState ingresosState;

  const _BalanceSummaryView({
    required this.gastosState,
    required this.ingresosState,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'es_ES',
      symbol: '€',
    );

    return gastosState.when(
      loading: () => const _BalanceLoadingCard(),
      error: (msg) => _BalanceErrorCard(mensaje: msg),
      loaded: (gastos) {
        return ingresosState.when(
          loading: () => const _BalanceLoadingCard(),
          error: (msg) => _BalanceErrorCard(mensaje: msg),
          loaded: (ingresos) {
            final totalGastos = gastos.fold<double>(
              0.0,
              (sum, item) => sum + item.cantidad,
            );
            final totalIngresos = ingresos.fold<double>(
              0.0,
              (sum, item) => sum + item.cantidad,
            );
            final balance = totalIngresos - totalGastos;

            return Card(
              margin: const EdgeInsets.all(12.0),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Balance Total',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      currencyFormatter.format(balance),
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: balance >= 0
                                ? const Color(0xFF64FFDA)
                                : const Color(0xFFCF6679),
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _IncomeExpenseTile(
                          title: 'Ingresos',
                          amount: totalIngresos,
                          color: const Color(0xFF64FFDA),
                          formatter: currencyFormatter,
                        ),
                        _IncomeExpenseTile(
                          title: 'Gastos',
                          amount: totalGastos,
                          color: const Color(0xFFCF6679),
                          formatter: currencyFormatter,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _BalanceLoadingCard extends StatelessWidget {
  const _BalanceLoadingCard();
  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(12.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(child: Text('Calculando balance...')),
      ),
    );
  }
}

class _BalanceErrorCard extends StatelessWidget {
  final String mensaje;
  const _BalanceErrorCard({required this.mensaje});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12.0),
      color: Theme.of(context).colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Error: $mensaje',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
          ),
        ),
      ),
    );
  }
}

class _IncomeExpenseTile extends StatelessWidget {
  final String title;
  final double amount;
  final Color color;
  final NumberFormat formatter;

  const _IncomeExpenseTile({
    required this.title,
    required this.amount,
    required this.color,
    required this.formatter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodySmall),
        Text(
          formatter.format(amount),
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
