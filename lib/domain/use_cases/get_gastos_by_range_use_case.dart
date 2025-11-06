import '../entities/gasto_entity.dart';
import '../repositories/gasto_repository.dart';

// Creamos una clase 'Params' para los argumentos
class GetGastosByRangeParams {
  final DateTime start;
  final DateTime end;

  GetGastosByRangeParams({required this.start, required this.end});
}

// El UseCase usa esa clase
class GetGastosByRangeUseCase {
  final GastoRepository _repository;

  GetGastosByRangeUseCase(this._repository);

  Future<List<GastoEntity>> call(GetGastosByRangeParams params) async {
    if (params.end.isBefore(params.start)) {
      throw Exception("La fecha final no puede ser anterior a la inicial.");
    }
    return _repository.getGastosByRange(params.start, params.end);
  }
}
