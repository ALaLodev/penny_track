import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:penny_track/core/config/router.dart';

import 'package:penny_track/features/gastos/presentation/cubits/lista_gastos_cubit.dart';
import 'package:penny_track/features/gastos/presentation/cubits/lista_gastos_state.dart';
import 'package:penny_track/features/ingresos/presentation/cubits/lista_ingresos_cubit.dart';
import 'package:penny_track/features/ingresos/presentation/cubits/lista_ingresos_state.dart';

import 'package:penny_track/features/gastos/presentation/widgets/lista_gastos_view.dart';
import 'package:penny_track/features/ingresos/presentation/widgets/lista_ingresos_view.dart';

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
    final gastosState = context.watch<ListaGastosCubit>().state;
    final ingresosState = context.watch<ListaIngresosCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Penny Track'),
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
          // Widget de resumen
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
    );
  }
}

// --- Widget privado para el resumen del balance ---
class _BalanceSummaryView extends StatelessWidget {
  final ListaGastosState gastosState;
  final ListaIngresosState ingresosState;

  const _BalanceSummaryView({
    required this.gastosState,
    required this.ingresosState,
  });

  @override
  Widget build(BuildContext context) {
    // Formateador de moneda
    final currencyFormatter = NumberFormat.currency(
      locale: 'es_ES',
      symbol: '€',
    );

    // Usamos 'when' anidados para manejar todos los casos de forma segura con Freezed.
    return gastosState.when(
      loading: () => const _BalanceLoadingCard(),
      error: (msg) => _BalanceErrorCard(mensaje: msg),
      loaded: (gastos) {
        return ingresosState.when(
          loading: () => const _BalanceLoadingCard(),
          error: (msg) => _BalanceErrorCard(mensaje: msg),

          // Si AMBOS están cargados (el "Happy Path")
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

            // Devolvemos el widget con los datos
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
                            color: balance >= 0 ? Colors.green : Colors.red,
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
                          color: Colors.green,
                          formatter: currencyFormatter,
                        ),
                        _IncomeExpenseTile(
                          title: 'Gastos',
                          amount: totalGastos,
                          color: Colors.red,
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

// --- Widgets auxiliares para el _BalanceSummaryView ---

class _BalanceLoadingCard extends StatelessWidget {
  const _BalanceLoadingCard();
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12.0),
      child: const Padding(
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
      color: Colors.red.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Error al cargar balance: $mensaje',
            style: TextStyle(color: Colors.red.shade900),
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
