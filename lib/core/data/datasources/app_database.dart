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
  int get schemaVersion => 4;
}
