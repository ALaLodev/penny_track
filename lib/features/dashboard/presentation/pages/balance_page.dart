import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:penny_track/features/gastos/presentation/cubits/lista_gastos_cubit.dart';
import 'package:penny_track/features/ingresos/presentation/cubits/lista_ingresos_cubit.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  DateTime _fechaSeleccionada = DateTime.now();

  void _cambiarMes(int meses) {
    setState(() {
      // Creamos una nueva fecha sumando o restando meses
      _fechaSeleccionada = DateTime(
        _fechaSeleccionada.year,
        _fechaSeleccionada.month + meses,
        1, // Fijamos el día 1 para evitar errores con meses de 30/31 días
      );
    });
  }

  // Helper para verificar si una fecha pertenece al mes seleccionado
  bool _esMismoMes(DateTime fecha) {
    return fecha.year == _fechaSeleccionada.year &&
        fecha.month == _fechaSeleccionada.month;
  }

  @override
  Widget build(BuildContext context) {
    final gastosState = context.watch<ListaGastosCubit>().state;
    final ingresosState = context.watch<ListaIngresosCubit>().state;

    final colorIngresos = Theme.of(context).colorScheme.primary;
    final colorGastos = Theme.of(context).colorScheme.error;

    double totalIngresosMes = 0;
    double totalGastosMes = 0;

    // Filtrado de datos
    ingresosState.whenOrNull(
      loaded: (lista) {
        final ingresosDelMes = lista.where((i) {
          final fechaSegura = i.fecha;
          return _esMismoMes(fechaSegura);
        });
        totalIngresosMes = ingresosDelMes.fold(
          0,
          (sum, item) => sum + item.cantidad,
        );
      },
    );

    gastosState.whenOrNull(
      loaded: (lista) {
        final gastosDelMes = lista.where(
          (g) => _esMismoMes(g.fecha ?? DateTime.now()),
        );
        totalGastosMes = gastosDelMes.fold(
          0,
          (sum, item) => sum + item.cantidad,
        );
      },
    );

    final bool isEmpty = totalIngresosMes == 0 && totalGastosMes == 0;
    final String nombreMes = DateFormat.yMMMM(
      'es_ES',
    ).format(_fechaSeleccionada);

    return Scaffold(
      appBar: AppBar(title: const Text('Balance Mensual')),
      body: Column(
        children: [
          // CONTROL DE MESES (Selector)
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () => _cambiarMes(-1), // Mes anterior
                ),
                Text(
                  nombreMes.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () => _cambiarMes(1), // Mes siguiente
                ),
              ],
            ),
          ),

          // --- CONTENIDO (Gráfico o Mensaje) ---
          Expanded(
            child: isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.insert_chart_outlined,
                          size: 60,
                          color: Colors.grey[700],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Sin movimientos en este mes',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Text(
                            'Distribución',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 40),

                          // GRÁFICO
                          SizedBox(
                            height: 250,
                            child: PieChart(
                              PieChartData(
                                sectionsSpace: 4,
                                centerSpaceRadius: 50,
                                sections: [
                                  // Sección Ingresos
                                  if (totalIngresosMes > 0)
                                    PieChartSectionData(
                                      color: colorIngresos.withValues(
                                        alpha: 0.8,
                                      ),
                                      value: totalIngresosMes,
                                      title:
                                          '${((totalIngresosMes / (totalIngresosMes + totalGastosMes)) * 100).toStringAsFixed(0)}%',
                                      radius: 60,
                                      titleStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  // Sección Gastos
                                  if (totalGastosMes > 0)
                                    PieChartSectionData(
                                      color: colorGastos.withValues(alpha: 0.8),
                                      value: totalGastosMes,
                                      title:
                                          '${((totalGastosMes / (totalIngresosMes + totalGastosMes)) * 100).toStringAsFixed(0)}%',
                                      radius: 60,
                                      titleStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),

                          // LEYENDA
                          _Indicator(
                            color: colorIngresos,
                            text: 'Ingresos',
                            amount: totalIngresosMes,
                          ),
                          const SizedBox(height: 10),
                          _Indicator(
                            color: colorGastos,
                            text: 'Gastos',
                            amount: totalGastosMes,
                          ),
                          const SizedBox(height: 20),
                          Divider(color: Colors.grey[800]),
                          const SizedBox(height: 10),

                          // BALANCE FINAL DEL MES
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Balance del mes",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                '${(totalIngresosMes - totalGastosMes).toStringAsFixed(2)}€',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      (totalIngresosMes - totalGastosMes) >= 0
                                      ? colorIngresos
                                      : colorGastos,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// Widget auxiliar
class _Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final double amount;

  const _Indicator({
    required this.color,
    required this.text,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Text(
          '${amount.toStringAsFixed(2)}€',
          style: TextStyle(fontSize: 16, color: Colors.grey[400]),
        ),
      ],
    );
  }
}
