import '../entities/ingreso_entity.dart';

abstract class IngresoRepository {
  Future<List<IngresoEntity>> getIngresos();

  Future<List<IngresoEntity>> getIngresosByRange(DateTime start, DateTime end);

  Future<IngresoEntity> saveIngreso(IngresoEntity ingreso);

  Future<void> deleteIngreso(String id);
}
