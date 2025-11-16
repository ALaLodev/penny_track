import '../repositories/ingreso_repository.dart';

class DeleteIngresoUseCase {
  final IngresoRepository _repository;

  DeleteIngresoUseCase(this._repository);

  Future<void> call(String id) {
    if (id.isEmpty) {
      throw Exception('El ID no puede estar vacío');
    }
    return _repository.deleteIngreso(id);
  }
}
