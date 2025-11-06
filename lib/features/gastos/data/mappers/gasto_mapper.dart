import '../../../../domain/entities/gasto_entity.dart';
import '../datasources/app_database.dart';
import 'package:drift/drift.dart'; // Importa el archivo de la DB para usar el modelo generado

// Convertir de DB Model (Gasto) a Domain Entity (GastoEntity)
GastoEntity toGastoEntity(Gasto model) {
  return GastoEntity(
    id: model.id,
    cantidad: model.cantidad,
    descripcion: model.descripcion,
    fecha: model.fecha,
    categoria: model.categoria,
  );
}

// Convertir de Domain Entity (GastoEntity) a Drift Table (GastosCompanion)
GastosCompanion toGastosCompanion(GastoEntity entity) {
  return GastosCompanion(
    id: entity.id != null ? Value(entity.id!) : const Value.absent(),
    cantidad: Value(entity.cantidad),
    descripcion: entity.descripcion != null
        ? Value(entity.descripcion!)
        : const Value.absent(),
    fecha: entity.fecha != null ? Value(entity.fecha!) : const Value.absent(),
    categoria: Value(entity.categoria),
  );
}
