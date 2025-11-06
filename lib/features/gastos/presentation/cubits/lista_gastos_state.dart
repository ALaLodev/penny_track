import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/gasto_entity.dart';

part 'lista_gastos_state.freezed.dart';

// 3. Crear la clase sellada (Union Type) con la anotación @freezed
@freezed
class ListaGastosState with _$ListaGastosState {
  // 4. Definir los diferentes "constructores" para cada estado

  // Estado 1: Cargando (no necesita datos)
  const factory ListaGastosState.loading() = _ListaGastosLoading;

  // Estado 2: Éxito (contiene la lista de gastos)
  const factory ListaGastosState.loaded({required List<GastoEntity> gastos}) =
      _ListaGastosLoaded;

  // Estado 3: Error (contiene un mensaje)
  const factory ListaGastosState.error({required String mensaje}) =
      _ListaGastosError;
}
