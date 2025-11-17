import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/router.dart';
import '../cubits/lista_ingresos_cubit.dart';
import '../cubits/lista_ingresos_state.dart';

class ListaIngresosPage extends StatelessWidget {
  const ListaIngresosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Ingresos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {
              final fin = DateTime.now();
              final inicio = fin.subtract(const Duration(days: 30));
              context.read<ListaIngresosCubit>().cargarIngresosPorRango(
                inicio,
                fin,
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.push(AppRoutes.nuevoIngreso);
        },
      ),
      body: const _ListaIngresosView(),
    );
  }
}

class _ListaIngresosView extends StatelessWidget {
  const _ListaIngresosView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListaIngresosCubit, ListaIngresosState>(
      builder: (context, state) {
        return state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (mensaje) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: $mensaje'),
                ElevatedButton(
                  onPressed: () =>
                      context.read<ListaIngresosCubit>().cargarIngresos(),
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
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
                    child: Text('${ingreso.cantidad.toStringAsFixed(0)}€'),
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
