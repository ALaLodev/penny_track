import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/config/service_locator.dart' as di;
import 'core/config/router.dart';
import 'features/gastos/presentation/cubits/lista_gastos_cubit.dart';
import 'core/config/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ListaGastosCubit>()..cargarGastos(),

      child: MaterialApp.router(
        routerConfig: appRouter,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        title: 'Gestor de Gastos',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
