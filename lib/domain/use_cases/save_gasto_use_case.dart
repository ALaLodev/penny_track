import '../entities/gasto_entity.dart';
import '../repositories/gasto_repository.dart';

class SaveGastoUseCase {
  final GastoRepository _repository;

  SaveGastoUseCase(this._repository);

  // El método 'call' ejecuta la lógica
  Future<GastoEntity> call(GastoEntity gasto) async {
    if (gasto.cantidad <= 0) {
      throw Exception("La cantidad del gasto debe ser mayor a cero.");
    }
    if (gasto.categoria.isEmpty) {
      throw Exception("El gasto debe tener una categoría.");
    }

    return _repository.saveGasto(gasto);
  }
}
