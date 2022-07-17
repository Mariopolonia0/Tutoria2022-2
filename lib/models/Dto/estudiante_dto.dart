class EstudianteDto {
  final String nombre;
  final int estudianteId;
  final int carreraId;
  final int personaId;
  final String matricula;
  final double balancetotal;
  final double balancependiente;

  EstudianteDto(
      {required this.nombre,
      required this.estudianteId,
      required this.carreraId,
      required this.personaId,
      required this.matricula,
      required this.balancetotal,
      required this.balancependiente});

  factory EstudianteDto.fromJson(Map<String, dynamic> json) {
    return EstudianteDto(
        nombre: json['nombre'],
        estudianteId: json['estudianteId'],
        carreraId: json['carreraId'],
        personaId: json['personaId'],
        matricula: json['matricula'],
        balancetotal: json['balancetotal'],
        balancependiente: json['balancependiente']);
  }
}
