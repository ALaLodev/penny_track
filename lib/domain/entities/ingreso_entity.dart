class IngresoEntity {
  final String? id;
  final double cantidad;
  final String descripcion;
  final DateTime fecha;
  final String fuente; // 'fuente' en lugar de 'categoria'

  IngresoEntity({
    this.id,
    required this.cantidad,
    required this.descripcion,
    required this.fecha,
    required this.fuente,
  });

  IngresoEntity copyWith({
    String? id,
    double? cantidad,
    String? descripcion,
    String? fuente,
    DateTime? fecha,
  }) {
    return IngresoEntity(
      id: id ?? this.id,
      cantidad: cantidad ?? this.cantidad,
      descripcion: descripcion ?? this.descripcion,
      fuente: fuente ?? this.fuente,
      fecha: fecha ?? this.fecha,
    );
  }
}
