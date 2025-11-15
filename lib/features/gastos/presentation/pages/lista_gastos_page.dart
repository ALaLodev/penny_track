import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/router.dart';
import '../cubits/lista_gastos_cubit.dart';
import '../cubits/lista_gastos_state.dart';

class ListaGastosPage extends StatelessWidget {
  const ListaGastosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Gastos'),
        actions: [
          // Botón para filtrar por rango
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {
              final fin = DateTime.now();
              final inicio = fin.subtract(const Duration(days: 30));
              context.read<ListaGastosCubit>().cargarGastosPorRango(
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
          // Ahora navega a la nueva ruta.
          context.push(AppRoutes.nuevoGasto);
        },
      ),

      body: const _ListaGastosView(),
    );
  }
}

/// Separamos la vista principal en un widget privado para mayor limpieza
class _ListaGastosView extends StatelessWidget {
  const _ListaGastosView();

  @override
  Widget build(BuildContext context) {
    // 6. BlocBuilder escucha los cambios de estado
    // (Este widget funciona gracias al BlocProvider que está en main.dart)
    return BlocBuilder<ListaGastosCubit, ListaGastosState>(
      builder: (context, state) {
        // 7. Usamos .when() (de freezed) para manejar CADA estado
        return state.when(
          // ---- ESTADO LOADING ----
          loading: () => const Center(child: CircularProgressIndicator()),

          // ---- ESTADO ERROR ----
          error: (mensaje) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: $mensaje'),
                ElevatedButton(
                  onPressed: () =>
                      context.read<ListaGastosCubit>().cargarGastos(),
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),

          // ---- ESTADO LOADED ----
          loaded: (gastos) {
            // Si la lista está vacía
            if (gastos.isEmpty) {
              return const Center(
                child: Text('No hay gastos todavía. ¡Añade uno!'),
              );
            }

            // Si hay gastos, mostramos la lista
            return ListView.builder(
              itemCount: gastos.length,
              itemBuilder: (context, index) {
                final gasto = gastos[index];

                return ListTile(
                  leading: CircleAvatar(
                    // Mostramos la cantidad formateada
                    child: Text('${gasto.cantidad.toStringAsFixed(0)}€'),
                  ),
                  title: Text(gasto.descripcion ?? 'Sin descripción'),
                  subtitle: Text(gasto.categoria),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      // context.read() es la forma de llamar a un método
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
