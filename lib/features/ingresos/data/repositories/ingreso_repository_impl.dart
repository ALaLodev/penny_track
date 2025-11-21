import 'package:penny_track/core/data/datasources/app_database.dart';
import 'package:drift/drift.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 💡 1. Importar Firebase
import 'package:penny_track/domain/entities/ingreso_entity.dart';
import 'package:penny_track/domain/repositories/ingreso_repository.dart';

class IngresoRepositoryImpl implements IngresoRepository {
  final AppDatabase _database;

  IngresoRepositoryImpl(this._database);

  // Getter para obtener el ID del usuario actual
  String? get _userId => FirebaseAuth.instance.currentUser?.uid;

  // --- Mapeadores (Convierten entre Entidad y Modelo de DB) ---

  IngresoEntity _toEntity(Ingreso data) {
    return IngresoEntity(
      id: data.id,
      userId: data.userId,
      cantidad: data.cantidad,
      descripcion: data.descripcion,
      fecha: data.fecha,
      fuente: data.fuente,
    );
  }

  IngresosCompanion _toCompanion(IngresoEntity entity) {
    return IngresosCompanion(
      id: entity.id != null ? Value(entity.id!) : const Value.absent(),
      // INYECTAR USER ID: Usamos el de la entidad O el del usuario logueado
      userId: Value(entity.userId ?? _userId),
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
    final uid = _userId;
    if (uid == null) return []; // Si no hay usuario, lista vacía

    // FILTRAR POR USUARIO
    final query = _database.select(_database.ingresos)
      ..where((tbl) => tbl.userId.equals(uid));

    final results = await query.get();
    return results.map(_toEntity).toList();
  }

  @override
  Future<List<IngresoEntity>> getIngresosByRange(
    DateTime start,
    DateTime end,
  ) async {
    final uid = _userId;
    if (uid == null) return [];

    // FILTRAR POR USUARIO Y RANGO
    final query = _database.select(_database.ingresos)
      ..where((tbl) {
        return tbl.userId.equals(uid) &
            tbl.fecha.isBiggerOrEqual(Variable(start)) &
            tbl.fecha.isSmallerOrEqual(Variable(end));
      });

    final results = await query.get();
    return results.map(_toEntity).toList();
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
