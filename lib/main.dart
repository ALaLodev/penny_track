import 'package:flutter/material.dart';
// Importa el archivo de configuración de GetIt
import 'core/config/service_locator.dart' as di; // di = dependency injection

void main() async {
  // Asegúrate de que Flutter esté inicializado
  WidgetsFlutterBinding.ensureInitialized();

  // 💡 LLAMA A LA INICIALIZACIÓN DE DEPENDENCIAS
  await di.initLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Aquí irá la configuración de GoRouter y los BlocProviders
    return MaterialApp(
      home: Scaffold(body: Center(child: Text('¡App Lista!'))),
    );
  }
}
