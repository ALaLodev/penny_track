import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/lista_gastos_cubit.dart';
import '../cubits/lista_gastos_state.dart';

class ListaGastosView extends StatelessWidget {
  const ListaGastosView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<ListaGastosCubit, ListaGastosState>(
      builder: (context, state) {
        return state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (mensaje) => Center(child: Text('Error: $mensaje')),
          loaded: (gastos) {
            if (gastos.isEmpty) {
              return const Center(child: Text('No hay gastos todavía.'));
            }
            return ListView.builder(
              itemCount: gastos.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final gasto = gastos[index];

                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: colors.error.withValues(alpha: 0.3),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            '${gasto.cantidad.toStringAsFixed(0)}€',
                            style: TextStyle(
                              color: colors.error,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      gasto.descripcion ?? 'Sin descripción',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      gasto.categoria,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_outline, color: colors.error),
                      onPressed: () {
                        context.read<ListaGastosCubit>().eliminarGasto(
                          gasto.id!,
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
