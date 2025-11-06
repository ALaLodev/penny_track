// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $GastosTable extends Gastos with TableInfo<$GastosTable, Gasto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GastosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => uuid.v4(),
  );
  static const VerificationMeta _cantidadMeta = const VerificationMeta(
    'cantidad',
  );
  @override
  late final GeneratedColumn<double> cantidad = GeneratedColumn<double>(
    'cantidad',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoriaMeta = const VerificationMeta(
    'categoria',
  );
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
    'categoria',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cantidad,
    descripcion,
    fecha,
    categoria,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gastos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Gasto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cantidad')) {
      context.handle(
        _cantidadMeta,
        cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta),
      );
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('categoria')) {
      context.handle(
        _categoriaMeta,
        categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta),
      );
    } else if (isInserting) {
      context.missing(_categoriaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Gasto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Gasto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      cantidad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cantidad'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
      categoria: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}categoria'],
      )!,
    );
  }

  @override
  $GastosTable createAlias(String alias) {
    return $GastosTable(attachedDatabase, alias);
  }
}

class Gasto extends DataClass implements Insertable<Gasto> {
  final String id;
  final double cantidad;
  final String descripcion;
  final DateTime fecha;
  final String categoria;
  const Gasto({
    required this.id,
    required this.cantidad,
    required this.descripcion,
    required this.fecha,
    required this.categoria,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['cantidad'] = Variable<double>(cantidad);
    map['descripcion'] = Variable<String>(descripcion);
    map['fecha'] = Variable<DateTime>(fecha);
    map['categoria'] = Variable<String>(categoria);
    return map;
  }

  GastosCompanion toCompanion(bool nullToAbsent) {
    return GastosCompanion(
      id: Value(id),
      cantidad: Value(cantidad),
      descripcion: Value(descripcion),
      fecha: Value(fecha),
      categoria: Value(categoria),
    );
  }

  factory Gasto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Gasto(
      id: serializer.fromJson<String>(json['id']),
      cantidad: serializer.fromJson<double>(json['cantidad']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      categoria: serializer.fromJson<String>(json['categoria']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'cantidad': serializer.toJson<double>(cantidad),
      'descripcion': serializer.toJson<String>(descripcion),
      'fecha': serializer.toJson<DateTime>(fecha),
      'categoria': serializer.toJson<String>(categoria),
    };
  }

  Gasto copyWith({
    String? id,
    double? cantidad,
    String? descripcion,
    DateTime? fecha,
    String? categoria,
  }) => Gasto(
    id: id ?? this.id,
    cantidad: cantidad ?? this.cantidad,
    descripcion: descripcion ?? this.descripcion,
    fecha: fecha ?? this.fecha,
    categoria: categoria ?? this.categoria,
  );
  Gasto copyWithCompanion(GastosCompanion data) {
    return Gasto(
      id: data.id.present ? data.id.value : this.id,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      categoria: data.categoria.present ? data.categoria.value : this.categoria,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Gasto(')
          ..write('id: $id, ')
          ..write('cantidad: $cantidad, ')
          ..write('descripcion: $descripcion, ')
          ..write('fecha: $fecha, ')
          ..write('categoria: $categoria')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, cantidad, descripcion, fecha, categoria);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Gasto &&
          other.id == this.id &&
          other.cantidad == this.cantidad &&
          other.descripcion == this.descripcion &&
          other.fecha == this.fecha &&
          other.categoria == this.categoria);
}

class GastosCompanion extends UpdateCompanion<Gasto> {
  final Value<String> id;
  final Value<double> cantidad;
  final Value<String> descripcion;
  final Value<DateTime> fecha;
  final Value<String> categoria;
  final Value<int> rowid;
  const GastosCompanion({
    this.id = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.fecha = const Value.absent(),
    this.categoria = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GastosCompanion.insert({
    this.id = const Value.absent(),
    required double cantidad,
    required String descripcion,
    required DateTime fecha,
    required String categoria,
    this.rowid = const Value.absent(),
  }) : cantidad = Value(cantidad),
       descripcion = Value(descripcion),
       fecha = Value(fecha),
       categoria = Value(categoria);
  static Insertable<Gasto> custom({
    Expression<String>? id,
    Expression<double>? cantidad,
    Expression<String>? descripcion,
    Expression<DateTime>? fecha,
    Expression<String>? categoria,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cantidad != null) 'cantidad': cantidad,
      if (descripcion != null) 'descripcion': descripcion,
      if (fecha != null) 'fecha': fecha,
      if (categoria != null) 'categoria': categoria,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GastosCompanion copyWith({
    Value<String>? id,
    Value<double>? cantidad,
    Value<String>? descripcion,
    Value<DateTime>? fecha,
    Value<String>? categoria,
    Value<int>? rowid,
  }) {
    return GastosCompanion(
      id: id ?? this.id,
      cantidad: cantidad ?? this.cantidad,
      descripcion: descripcion ?? this.descripcion,
      fecha: fecha ?? this.fecha,
      categoria: categoria ?? this.categoria,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<double>(cantidad.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GastosCompanion(')
          ..write('id: $id, ')
          ..write('cantidad: $cantidad, ')
          ..write('descripcion: $descripcion, ')
          ..write('fecha: $fecha, ')
          ..write('categoria: $categoria, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GastosTable gastos = $GastosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [gastos];
}

typedef $$GastosTableCreateCompanionBuilder =
    GastosCompanion Function({
      Value<String> id,
      required double cantidad,
      required String descripcion,
      required DateTime fecha,
      required String categoria,
      Value<int> rowid,
    });
typedef $$GastosTableUpdateCompanionBuilder =
    GastosCompanion Function({
      Value<String> id,
      Value<double> cantidad,
      Value<String> descripcion,
      Value<DateTime> fecha,
      Value<String> categoria,
      Value<int> rowid,
    });

class $$GastosTableFilterComposer
    extends Composer<_$AppDatabase, $GastosTable> {
  $$GastosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoria => $composableBuilder(
    column: $table.categoria,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GastosTableOrderingComposer
    extends Composer<_$AppDatabase, $GastosTable> {
  $$GastosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoria => $composableBuilder(
    column: $table.categoria,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GastosTableAnnotationComposer
    extends Composer<_$AppDatabase, $GastosTable> {
  $$GastosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<String> get categoria =>
      $composableBuilder(column: $table.categoria, builder: (column) => column);
}

class $$GastosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GastosTable,
          Gasto,
          $$GastosTableFilterComposer,
          $$GastosTableOrderingComposer,
          $$GastosTableAnnotationComposer,
          $$GastosTableCreateCompanionBuilder,
          $$GastosTableUpdateCompanionBuilder,
          (Gasto, BaseReferences<_$AppDatabase, $GastosTable, Gasto>),
          Gasto,
          PrefetchHooks Function()
        > {
  $$GastosTableTableManager(_$AppDatabase db, $GastosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GastosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GastosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GastosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<double> cantidad = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
                Value<String> categoria = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GastosCompanion(
                id: id,
                cantidad: cantidad,
                descripcion: descripcion,
                fecha: fecha,
                categoria: categoria,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required double cantidad,
                required String descripcion,
                required DateTime fecha,
                required String categoria,
                Value<int> rowid = const Value.absent(),
              }) => GastosCompanion.insert(
                id: id,
                cantidad: cantidad,
                descripcion: descripcion,
                fecha: fecha,
                categoria: categoria,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GastosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GastosTable,
      Gasto,
      $$GastosTableFilterComposer,
      $$GastosTableOrderingComposer,
      $$GastosTableAnnotationComposer,
      $$GastosTableCreateCompanionBuilder,
      $$GastosTableUpdateCompanionBuilder,
      (Gasto, BaseReferences<_$AppDatabase, $GastosTable, Gasto>),
      Gasto,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GastosTableTableManager get gastos =>
      $$GastosTableTableManager(_db, _db.gastos);
}
