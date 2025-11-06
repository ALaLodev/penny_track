import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

//Instanciar el objeto Uuid para poder llamar a v4()
const uuid = Uuid();

class Gastos extends Table {
  // Las tablas deben heredar de Table y definir las columnas
  // El ID se genera automáticamente en el cliente si no se proporciona
  TextColumn get id =>
      text().withLength(max: 36).clientDefault(() => uuid.v4())();
  RealColumn get cantidad => real()();
  TextColumn get descripcion => text().withLength(min: 1).nullable()();
  DateTimeColumn get fecha => dateTime().nullable()();
  TextColumn get categoria => text()();

  // Primary Key
  @override
  Set<Column> get primaryKey => {id};
}

// Esta función abstracta debe estar fuera de la clase AppDatabase
LazyDatabase _openConnection() {
  // Retrasamos la apertura de la DB hasta que se necesite
  return LazyDatabase(() async {
    // Obtener el directorio de documentos del SO
    final dbFolder = await getApplicationDocumentsDirectory();

    // Crear la ruta completa al archivo de la base de datos
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    // Devolver la conexión de la DB
    return NativeDatabase(file);
  });
}

// Este es el archivo de la base de datos que usaremos en la app
@DriftDatabase(tables: [Gastos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;
}
