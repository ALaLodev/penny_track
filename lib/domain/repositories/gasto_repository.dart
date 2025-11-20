import 'package:penny_track/domain/entities/gasto_entity.dart';

abstract class GastoRepository {
  Future<List<GastoEntity>> getGastos();

  Future<List<GastoEntity>> getGastosByRange(DateTime start, DateTime end);

  Future<GastoEntity> saveGasto(GastoEntity gasto);

  Future<void> deleteGasto(String id);
}
