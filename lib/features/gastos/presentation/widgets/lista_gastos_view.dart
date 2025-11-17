import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/lista_gastos_cubit.dart';
import '../cubits/lista_gastos_state.dart';

class ListaGastosView extends StatelessWidget {
  const ListaGastosView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListaGastosCubit, ListaGastosState>(
      builder: (context, state) {
        return state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (mensaje) => Center(child: Text('Error: $mensaje')),
          loaded: (gastos) {
            if (gastos.isEmpty) {
              return const Center(
                child: Text('No hay gastos todavía. ¡Añade uno!'),
              );
            }
            return ListView.builder(
              itemCount: gastos.length,
              itemBuilder: (context, index) {
                final gasto = gastos[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text('${gasto.cantidad.toStringAsFixed(0)}€'),
                    ),
                  ),
                  title: Text(gasto.descripcion ?? 'Sin descripción'),
                  subtitle: Text(gasto.categoria),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      context.read<ListaGastosCubit>().eliminarGasto(gasto.id!);
                    },
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
