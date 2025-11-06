import 'package:penny_track/domain/entities/gasto_entity.dart';

abstract class GastoRepository {
  Future<List<GastoEntity>> getGastos();

  // 2. Obtener gastos en un rango (ej: para la vista del mes)
  Future<List<GastoEntity>> getGastosByRange(DateTime start, DateTime end);

  // 3. Guardar un nuevo gasto (devuelve el gasto con el ID generado)
  Future<GastoEntity> saveGasto(GastoEntity gasto);

  Future<void> deleteGasto(String id);
}
