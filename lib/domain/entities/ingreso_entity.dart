class IngresoEntity {
  final String? id;
  final String? userId;
  final double cantidad;
  final String descripcion;
  final DateTime fecha;
  final String fuente;

  IngresoEntity({
    this.id,
    this.userId,
    required this.cantidad,
    required this.descripcion,
    required this.fecha,
    required this.fuente,
  });

  IngresoEntity copyWith({
    String? id,
    String? userId,
    double? cantidad,
    String? descripcion,
    String? fuente,
    DateTime? fecha,
  }) {
    return IngresoEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      cantidad: cantidad ?? this.cantidad,
      descripcion: descripcion ?? this.descripcion,
      fuente: fuente ?? this.fuente,
      fecha: fecha ?? this.fecha,
    );
  }
}
