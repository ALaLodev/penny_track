import 'package:penny_track/core/data/datasources/app_database.dart';
import 'package:drift/drift.dart';
import 'package:penny_track/domain/entities/ingreso_entity.dart';
import 'package:penny_track/domain/repositories/ingreso_repository.dart';

class IngresoRepositoryImpl implements IngresoRepository {
  final AppDatabase _database;

  IngresoRepositoryImpl(this._database);

  // --- Mapeadores (Convierten entre Entidad y Modelo de DB) ---

  IngresoEntity _toEntity(Ingreso data) {
    return IngresoEntity(
      id: data.id,
      cantidad: data.cantidad,
      descripcion: data.descripcion,
      fecha: data.fecha,
      fuente: data.fuente,
    );
  }

  IngresosCompanion _toCompanion(IngresoEntity entity) {
    return IngresosCompanion(
      id: entity.id != null ? Value(entity.id!) : const Value.absent(),
      cantidad: Value(entity.cantidad),
      descripcion: Value(entity.descripcion),
      fecha: Value(entity.fecha),
      fuente: Value(entity.fuente),
    );
  }
  // --- Fin Mapeadores ---

  @override
  Future<void> deleteIngreso(String id) {
    return (_database.delete(
      _database.ingresos,
    )..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<List<IngresoEntity>> getIngresos() async {
    final results = await _database.select(_database.ingresos).get();
    return results.map(_toEntity).toList();
  }

  @override
  Future<List<IngresoEntity>> getIngresosByRange(DateTime start, DateTime end) {
    // Implementa la lógica de rango si la necesitas
    return getIngresos(); // Simplificado por ahora
  }

  @override
  Future<IngresoEntity> saveIngreso(IngresoEntity ingreso) async {
    final companion = _toCompanion(ingreso);
    // 'insertReturning' nos devuelve el objeto con el ID generado
    final result = await _database
        .into(_database.ingresos)
        .insertReturning(companion);
    return _toEntity(result);
  }
}
