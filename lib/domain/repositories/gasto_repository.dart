import 'package:penny_track/domain/entities/gasto_entity.dart';

abstract class GastoRepository {
  Future<List<GastoEntity>> getGastos();

  //Obtener gastos en un rango (ej: para la vista del mes)
  Future<List<GastoEntity>> getGastosByRange(DateTime start, DateTime end);

  Future<GastoEntity> saveGasto(GastoEntity gasto);

  Future<void> deleteGasto(String id);
}
