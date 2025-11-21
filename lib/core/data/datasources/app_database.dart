import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

//Instancia el objeto Uuid para poder llamar a v4()
const uuid = Uuid();

class Gastos extends Table {
  TextColumn get id =>
      text().withLength(max: 36).clientDefault(() => uuid.v4())();
  TextColumn get userId => text().nullable()();
  RealColumn get cantidad => real()();
  TextColumn get descripcion => text().withLength(min: 1)();
  DateTimeColumn get fecha => dateTime()();
  TextColumn get categoria => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class Ingresos extends Table {
  TextColumn get id =>
      text().withLength(max: 36).clientDefault(() => uuid.v4())();
  TextColumn get userId => text().nullable()();
  RealColumn get cantidad => real()();
  TextColumn get descripcion => text()();
  DateTimeColumn get fecha => dateTime()();
  TextColumn get fuente => text()();

  @override
  Set<Column> get primaryKey => {id};
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Gastos, Ingresos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      // Si la base de datos no existe, créala toda nueva
      onCreate: (Migrator m) async {
        await m.createAll();
      },

      // Si la base de datos YA existe pero es vieja...
      onUpgrade: (Migrator m, int from, int to) async {
        // Si la versión vieja es menor que 4...
        if (from < 5) {
          // ...añade las columnas que faltan manualmente
          await m.addColumn(gastos, gastos.userId);
          await m.addColumn(ingresos, ingresos.userId);
        }
      },
    );
  }
}
