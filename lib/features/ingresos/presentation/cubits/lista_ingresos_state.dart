import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/ingreso_entity.dart';

part 'lista_ingresos_state.freezed.dart';

@freezed
class ListaIngresosState with _$ListaIngresosState {
  const factory ListaIngresosState.loading() = _Loading;

  const factory ListaIngresosState.loaded({
    required List<IngresoEntity> ingresos,
  }) = _Loaded;

  const factory ListaIngresosState.error({required String mensaje}) = _Error;
}
