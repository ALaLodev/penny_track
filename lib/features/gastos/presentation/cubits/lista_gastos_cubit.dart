import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/gasto_entity.dart';
import '../../../../domain/use_cases/delete_gasto_use_case.dart';
import '../../../../domain/use_cases/get_gastos_use_case.dart';
import '../../../../domain/use_cases/save_gasto_use_case.dart';
import '../../../../domain/use_cases/get_gastos_by_range_use_case.dart';
import 'lista_gastos_state.dart';

class ListaGastosCubit extends Cubit<ListaGastosState> {
  final GetGastosUseCase _getGastosUseCase;
  final SaveGastoUseCase _saveGastoUseCase;
  final DeleteGastoUseCase _deleteGastoUseCase;
  final GetGastosByRangeUseCase _getGastosByRangeUseCase;

  ListaGastosCubit({
    required GetGastosUseCase getGastosUseCase,
    required SaveGastoUseCase saveGastoUseCase,
    required DeleteGastoUseCase deleteGastoUseCase,
    required GetGastosByRangeUseCase getGastosByRangeUseCase,
  }) : _getGastosUseCase = getGastosUseCase,
       _saveGastoUseCase = saveGastoUseCase,
       _deleteGastoUseCase = deleteGastoUseCase,
       _getGastosByRangeUseCase = getGastosByRangeUseCase,
       super(const ListaGastosState.loading());

  // --- MÉTODOS PÚBLICOS ---

  Future<void> cargarGastos() async {
    try {
      emit(const ListaGastosState.loading());
      final gastos = await _getGastosUseCase();
      emit(ListaGastosState.loaded(gastos: gastos));
    } catch (e) {
      emit(
        ListaGastosState.error(
          mensaje: "Error al cargar gastos: ${e.toString()}",
        ),
      );
    }
  }

  Future<void> cargarGastosPorRango(DateTime inicio, DateTime fin) async {
    try {
      emit(const ListaGastosState.loading());

      // Creamos el objeto de parámetros que espera el UseCase
      final params = GetGastosByRangeParams(start: inicio, end: fin);

      // Llamamos al UseCase específico
      final gastos = await _getGastosByRangeUseCase(params);

      emit(ListaGastosState.loaded(gastos: gastos));
    } catch (e) {
      emit(
        ListaGastosState.error(
          mensaje: "Error al filtrar gastos: ${e.toString()}",
        ),
      );
    }
  }

  Future<void> agregarGasto(GastoEntity nuevoGasto) async {
    try {
      final gastoGuardado = await _saveGastoUseCase(nuevoGasto);
      state.maybeWhen(
        loaded: (listaActual) {
          final updatedList = List<GastoEntity>.from(listaActual)
            ..add(gastoGuardado);
          emit(ListaGastosState.loaded(gastos: updatedList));
        },
        orElse: () => cargarGastos(),
      );
    } catch (e) {
      emit(
        ListaGastosState.error(mensaje: "Error al guardar: ${e.toString()}"),
      );
    }
  }

  Future<void> eliminarGasto(String id) async {
    try {
      await _deleteGastoUseCase(id);
      state.maybeWhen(
        loaded: (listaActual) {
          final updatedList = listaActual
              .where((gasto) => gasto.id != id)
              .toList();
          emit(ListaGastosState.loaded(gastos: updatedList));
        },
        orElse: () => cargarGastos(),
      );
    } catch (e) {
      emit(
        ListaGastosState.error(mensaje: "Error al eliminar: ${e.toString()}"),
      );
    }
  }
}
