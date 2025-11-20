import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/gasto_entity.dart';

part 'lista_gastos_state.freezed.dart';

// Crear la clase sellada (Union Type) con la anotación @freezed
@freezed
class ListaGastosState with _$ListaGastosState {
  // Definir los diferentes "constructores" para cada estado

  const factory ListaGastosState.loading() = _ListaGastosLoading;

  const factory ListaGastosState.loaded({required List<GastoEntity> gastos}) =
      _ListaGastosLoaded;

  const factory ListaGastosState.error({required String mensaje}) =
      _ListaGastosError;
}
