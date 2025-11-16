import '../entities/ingreso_entity.dart';
import '../repositories/ingreso_repository.dart';

class GetIngresosUseCase {
  final IngresoRepository _repository;

  GetIngresosUseCase(this._repository);

  // El método 'call' permite que la clase sea "invocable"
  Future<List<IngresoEntity>> call() async {
    return _repository.getIngresos();
  }
}
