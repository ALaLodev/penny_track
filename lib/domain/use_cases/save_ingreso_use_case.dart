import '../entities/ingreso_entity.dart';
import '../repositories/ingreso_repository.dart';

class SaveIngresoUseCase {
  final IngresoRepository _repository;

  SaveIngresoUseCase(this._repository);

  Future<IngresoEntity> call(IngresoEntity ingreso) {
    if (ingreso.cantidad <= 0) {
      throw Exception('La cantidad debe ser positiva');
    }
    if (ingreso.descripcion.isEmpty) {
      throw Exception('La descripción no puede estar vacía');
    }

    return _repository.saveIngreso(ingreso);
  }
}
