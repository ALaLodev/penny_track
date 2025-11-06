import '../entities/gasto_entity.dart';
import '../repositories/gasto_repository.dart';

class GetGastosUseCase {
  final GastoRepository _repository;

  // Se inyecta la dependencia del Repositorio (lo hará GetIt)
  GetGastosUseCase(this._repository);

  Future<List<GastoEntity>> call() async {
    return _repository.getGastos();
  }
}
