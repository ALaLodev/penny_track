import 'package:flutter_bloc/flutter_bloc.dart';
// 💡 Importa las dependencias de INGRESO
import '../../../../domain/entities/ingreso_entity.dart';
import '../../../../domain/use_cases/delete_ingreso_use_case.dart';
import '../../../../domain/use_cases/get_ingresos_use_case.dart';
import '../../../../domain/use_cases/save_ingreso_use_case.dart';
import '../../../../domain/use_cases/get_ingresos_by_range_use_case.dart';
import 'lista_ingresos_state.dart'; // 💡 Importa el estado de INGRESO

// 💡 Renombra la clase
class ListaIngresosCubit extends Cubit<ListaIngresosState> {
  // 1. Dependencias (UseCases de Ingreso)
  final GetIngresosUseCase _getIngresosUseCase;
  final SaveIngresoUseCase _saveIngresoUseCase;
  final DeleteIngresoUseCase _deleteIngresoUseCase;
  final GetIngresosByRangeUseCase _getIngresosByRangeUseCase;

  // 2. Constructor
  ListaIngresosCubit({
    required GetIngresosUseCase getIngresosUseCase,
    required SaveIngresoUseCase saveIngresoUseCase,
    required DeleteIngresoUseCase deleteIngresoUseCase,
    required GetIngresosByRangeUseCase getIngresosByRangeUseCase,
  }) : _getIngresosUseCase = getIngresosUseCase,
       _saveIngresoUseCase = saveIngresoUseCase,
       _deleteIngresoUseCase = deleteIngresoUseCase,
       _getIngresosByRangeUseCase = getIngresosByRangeUseCase,
       super(const ListaIngresosState.loading());

  // --- MÉTODOS PÚBLICOS ---

  Future<void> cargarIngresos() async {
    try {
      emit(const ListaIngresosState.loading());
      final ingresos = await _getIngresosUseCase();
      emit(ListaIngresosState.loaded(ingresos: ingresos));
    } catch (e) {
      emit(
        ListaIngresosState.error(
          mensaje: "Error al cargar ingresos: ${e.toString()}",
        ),
      );
    }
  }

  Future<void> cargarIngresosPorRango(DateTime inicio, DateTime fin) async {
    try {
      emit(const ListaIngresosState.loading());
      final params = GetIngresosByRangeParams(start: inicio, end: fin);
      final ingresos = await _getIngresosByRangeUseCase(params);
      emit(ListaIngresosState.loaded(ingresos: ingresos));
    } catch (e) {
      emit(
        ListaIngresosState.error(
          mensaje: "Error al filtrar ingresos: ${e.toString()}",
        ),
      );
    }
  }

  Future<void> agregarIngreso(IngresoEntity nuevoIngreso) async {
    try {
      final ingresoGuardado = await _saveIngresoUseCase(nuevoIngreso);
      state.maybeWhen(
        loaded: (listaActual) {
          final updatedList = List<IngresoEntity>.from(listaActual)
            ..add(ingresoGuardado);
          emit(ListaIngresosState.loaded(ingresos: updatedList));
        },
        orElse: () => cargarIngresos(),
      );
    } catch (e) {
      emit(
        ListaIngresosState.error(mensaje: "Error al guardar: ${e.toString()}"),
      );
    }
  }

  Future<void> eliminarIngreso(String id) async {
    try {
      await _deleteIngresoUseCase(id);
      state.maybeWhen(
        loaded: (listaActual) {
          final updatedList = listaActual
              .where((ingreso) => ingreso.id != id)
              .toList();
          emit(ListaIngresosState.loaded(ingresos: updatedList));
        },
        orElse: () => cargarIngresos(),
      );
    } catch (e) {
      emit(
        ListaIngresosState.error(mensaje: "Error al eliminar: ${e.toString()}"),
      );
    }
  }
}
