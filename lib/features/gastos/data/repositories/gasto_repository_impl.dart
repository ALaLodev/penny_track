import 'package:drift/drift.dart';
import '../../../../domain/entities/gasto_entity.dart';
import '../../../../domain/repositories/gasto_repository.dart';
import '../../../../core/data/datasources/app_database.dart'; // La DB
import '../mappers/gasto_mapper.dart'; // Los mappers

class GastoRepositoryImpl implements GastoRepository {
  final AppDatabase _db; // Drift DB inyectada

  GastoRepositoryImpl(this._db);

  @override
  Future<List<GastoEntity>> getGastos() async {
    // Obtener los datos de la DB
    final models = await _db
        .select(_db.gastos)
        .get(); // _db.gastos es la tabla generada

    // Mapear de modelos (drift) a entidades (domain)
    return models.map((model) => toGastoEntity(model)).toList();
  }

  @override
  Future<GastoEntity> saveGasto(GastoEntity gasto) async {
    // Convertir la entidad a un 'Companion' (formato de inserción de drift)
    final companion = toGastosCompanion(gasto);

    // Insertar y obtener el ID
    final gastoGenerado = await _db.into(_db.gastos).insertReturning(companion);

    // Devolver la entidad original y si viene sin ID, la DB lo genera.
    return toGastoEntity(gastoGenerado);
  }

  @override
  Future<void> deleteGasto(String id) async {
    // Definimos una 'query' para borrar
    await (_db.delete(_db.gastos)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<List<GastoEntity>> getGastosByRange(
    DateTime start,
    DateTime end,
  ) async {
    // Definimos la consulta (query)
    final query = _db.select(_db.gastos)
      ..where((tbl) {
        return tbl.fecha.isNotNull() &
            tbl.fecha.isBiggerOrEqual(Variable(start)) &
            tbl.fecha.isSmallerOrEqual(Variable(end));
      });

    // Ejecutamos y mapeamos los resultados
    final models = await query.get();
    return models.map((model) => toGastoEntity(model)).toList();
  }
}
