import '../repositories/gasto_repository.dart';

class DeleteGastoUseCase {
  final GastoRepository _repository;

  DeleteGastoUseCase(this._repository);

  Future<void> call(String id) async {
    if (id.isEmpty) {
      throw Exception("ID inválido para eliminar.");
    }
    return _repository.deleteGasto(id);
  }
}
