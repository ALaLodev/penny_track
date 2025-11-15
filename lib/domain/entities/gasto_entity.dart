class GastoEntity {
  final String? id;
  final double cantidad;
  final String? descripcion;
  final String categoria;
  final DateTime? fecha;

  GastoEntity({
    this.id,
    required this.cantidad,
    required this.descripcion,
    required this.categoria,
    required this.fecha,
  });

  GastoEntity copyWith({
    String? id,
    double? cantidad,
    String? descripcion,
    String? categoria,
    DateTime? fecha,
  }) {
    return GastoEntity(
      id: id ?? this.id,
      cantidad: cantidad ?? this.cantidad,
      descripcion: descripcion ?? this.descripcion,
      categoria: categoria ?? this.categoria,
      fecha: fecha ?? this.fecha,
    );
  }
}
