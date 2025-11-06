import '../entities/gasto_entity.dart';
import '../repositories/gasto_repository.dart';

class GetGastosUseCase {
  final GastoRepository _repository;

  // Se inyecta la dependencia del Repositorio (lo hará GetIt)
  GetGastosUseCase(this._repository);

  // El método de ejecución
  Future<List<GastoEntity>> call() async {
    // Aquí podrías agregar lógica de negocio (ej: filtrar, ordenar, etc.)
    return _repository.getGastos();
  }
}
