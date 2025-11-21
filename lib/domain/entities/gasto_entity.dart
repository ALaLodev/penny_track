class GastoEntity {
  final String? id;
  final String? userId;
  final double cantidad;
  final String? descripcion;
  final String categoria;
  final DateTime? fecha;

  GastoEntity({
    this.id,
    this.userId,
    required this.cantidad,
    required this.descripcion,
    required this.categoria,
    required this.fecha,
  });

  GastoEntity copyWith({
    String? id,
    String? userId,
    double? cantidad,
    String? descripcion,
    String? categoria,
    DateTime? fecha,
  }) {
    return GastoEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      cantidad: cantidad ?? this.cantidad,
      descripcion: descripcion ?? this.descripcion,
      categoria: categoria ?? this.categoria,
      fecha: fecha ?? this.fecha,
    );
  }
}
