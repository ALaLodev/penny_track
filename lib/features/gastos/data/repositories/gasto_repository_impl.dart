import 'package:drift/drift.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 💡 1. Importar Firebase
import '../../../../domain/entities/gasto_entity.dart';
import '../../../../domain/repositories/gasto_repository.dart';
import '../../../../core/data/datasources/app_database.dart';

class GastoRepositoryImpl implements GastoRepository {
  final AppDatabase _db;

  GastoRepositoryImpl(this._db);

  // 💡 2. Getter para obtener el ID del usuario actual
  String? get _userId => FirebaseAuth.instance.currentUser?.uid;

  // --- MAPEADORES INTERNOS (Para asegurar el manejo del userId) ---

  GastoEntity _toEntity(Gasto model) {
    return GastoEntity(
      id: model.id,
      userId: model.userId, // Mapeamos el usuario
      cantidad: model.cantidad,
      descripcion: model.descripcion,
      fecha: model.fecha,
      categoria: model.categoria,
    );
  }

  GastosCompanion _toCompanion(GastoEntity entity) {
    return GastosCompanion(
      id: entity.id != null ? Value(entity.id!) : const Value.absent(),
      // 💡 3. INYECTAR USER ID: Usamos el de la entidad O el del usuario logueado
      userId: Value(entity.userId ?? _userId),
      cantidad: Value(entity.cantidad),
      descripcion: Value(entity.descripcion ?? 'Sin descripción'),
      fecha: Value(entity.fecha ?? DateTime.now()),
      categoria: Value(entity.categoria),
    );
  }

  // --- IMPLEMENTACIÓN DE MÉTODOS ---

  @override
  Future<List<GastoEntity>> getGastos() async {
    final uid = _userId;
    if (uid == null) return []; // Si no hay usuario, lista vacía

    // 💡 4. FILTRAR POR USUARIO
    final query = _db.select(_db.gastos)
      ..where((tbl) => tbl.userId.equals(uid));

    final models = await query.get();
    return models.map(_toEntity).toList();
  }

  @override
  Future<GastoEntity> saveGasto(GastoEntity gasto) async {
    // Convertimos a Companion (aquí se inyecta el userId automáticamente)
    final companion = _toCompanion(gasto);

    // Insertamos y recuperamos el dato guardado
    final gastoGenerado = await _db.into(_db.gastos).insertReturning(companion);

    return _toEntity(gastoGenerado);
  }

  @override
  Future<void> deleteGasto(String id) async {
    // Borramos asegurándonos de que coincida el ID
    await (_db.delete(_db.gastos)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<List<GastoEntity>> getGastosByRange(
    DateTime start,
    DateTime end,
  ) async {
    final uid = _userId;
    if (uid == null) return [];

    final query = _db.select(_db.gastos)
      ..where((tbl) {
        // 💡 5. FILTRAR POR USUARIO Y POR FECHA
        return tbl.userId.equals(uid) & // Filtro de usuario
            tbl.fecha.isBiggerOrEqual(Variable(start)) &
            tbl.fecha.isSmallerOrEqual(Variable(end));
      });

    final models = await query.get();
    return models.map(_toEntity).toList();
  }
}
