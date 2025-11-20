import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/lista_ingresos_cubit.dart';
import '../cubits/lista_ingresos_state.dart';

class ListaIngresosView extends StatelessWidget {
  const ListaIngresosView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<ListaIngresosCubit, ListaIngresosState>(
      builder: (context, state) {
        return state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (mensaje) => Center(child: Text('Error: $mensaje')),
          loaded: (ingresos) {
            if (ingresos.isEmpty) {
              return const Center(child: Text('No hay ingresos todavía.'));
            }
            return ListView.builder(
              itemCount: ingresos.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final ingreso = ingresos[index];

                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: colors.primary.withValues(alpha: 0.3),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            '${ingreso.cantidad.toStringAsFixed(0)}€',
                            style: TextStyle(
                              color: colors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      ingreso.descripcion,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      ingreso.fuente,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_outline, color: colors.error),
                      onPressed: () {
                        context.read<ListaIngresosCubit>().eliminarIngreso(
                          ingreso.id!,
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
