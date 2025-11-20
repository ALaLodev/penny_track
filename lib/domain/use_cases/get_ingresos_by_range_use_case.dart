import '../entities/ingreso_entity.dart';
import '../repositories/ingreso_repository.dart';

class GetIngresosByRangeParams {
  final DateTime start;
  final DateTime end;

  GetIngresosByRangeParams({required this.start, required this.end});
}

class GetIngresosByRangeUseCase {
  final IngresoRepository _repository;

  GetIngresosByRangeUseCase(this._repository);

  Future<List<IngresoEntity>> call(GetIngresosByRangeParams params) {
    if (params.end.isBefore(params.start)) {
      throw Exception('La fecha final no puede ser anterior a la inicial');
    }
    return _repository.getIngresosByRange(params.start, params.end);
  }
}
