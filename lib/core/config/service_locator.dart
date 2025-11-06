import 'package:get_it/get_it.dart';
import 'package:penny_track/domain/use_cases/delete_gasto_use_case.dart';
import 'package:penny_track/domain/use_cases/get_gastos_by_range_use_case.dart';
import 'package:penny_track/domain/use_cases/save_gasto_use_case.dart';
import 'package:penny_track/features/gastos/presentation/cubits/lista_gastos_cubit.dart';
import '../../features/gastos/data/datasources/app_database.dart';
import '../../domain/repositories/gasto_repository.dart';
import '../../features/gastos/data/repositories/gasto_repository_impl.dart';
import '../../domain/use_cases/get_gastos_use_case.dart';

final sl = GetIt.instance; //sl = Service Locator

// Función que se llamará en main.dart
Future<void> initLocator() async {
  // --- CAPA DATA ---
  sl.registerSingleton<AppDatabase>(AppDatabase());
  sl.registerLazySingleton<GastoRepository>(() => GastoRepositoryImpl(sl()));

  // --- CAPA DOMAIN (Use Cases) ---
  // 2. Registrar todos los UseCases
  sl.registerLazySingleton(() => GetGastosUseCase(sl()));
  sl.registerLazySingleton(() => SaveGastoUseCase(sl()));
  sl.registerLazySingleton(() => DeleteGastoUseCase(sl()));
  sl.registerLazySingleton(() => GetGastosByRangeUseCase(sl()));

  // --- CAPA PRESENTATION (Blocs/Cubits) ---
  sl.registerFactory(
    () => ListaGastosCubit(
      // 3. Inyectar TODOS los UseCases que el Cubit necesita
      getGastosUseCase: sl(),
      saveGastoUseCase: sl(),
      deleteGastoUseCase: sl(),
      getGastosByRangeUseCase: sl(),
    ),
  );
}
