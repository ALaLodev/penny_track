import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/lista_ingresos_cubit.dart';
import '../cubits/lista_ingresos_state.dart';

class ListaIngresosView extends StatelessWidget {
  const ListaIngresosView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListaIngresosCubit, ListaIngresosState>(
      builder: (context, state) {
        return state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (mensaje) => Center(child: Text('Error: $mensaje')),
          loaded: (ingresos) {
            if (ingresos.isEmpty) {
              return const Center(
                child: Text('No hay ingresos todavía. ¡Añade uno!'),
              );
            }
            return ListView.builder(
              itemCount: ingresos.length,
              itemBuilder: (context, index) {
                final ingreso = ingresos[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.green.shade100,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${ingreso.cantidad.toStringAsFixed(0)}€',
                        style: TextStyle(color: Colors.green.shade900),
                      ),
                    ),
                  ),
                  title: Text(ingreso.descripcion),
                  subtitle: Text(ingreso.fuente),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      context.read<ListaIngresosCubit>().eliminarIngreso(
                        ingreso.id!,
                      );
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
