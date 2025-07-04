class Tarea {
  final String id;
  String titulo;
  bool completada;

  Tarea({
    required this.id,
    required this.titulo,
    this.completada = false,
  });

  factory Tarea.fromJson(Map<String, dynamic> json) {
    return Tarea(
      id: json['id'],
      titulo: json['titulo'],
      completada: json['completada'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'completada': completada,
    };
  }
}
