class RegistroSaude {
  final String id;
  final String alunoId;
  final DateTime dataRegistro;
  final double? pesoKg;
  final double? alturaCm;
  final double? imc; // Calculated
  final String? pressaoArterial; // e.g., "120/80"
  final double? glicemiaMgDl;
  final String? observacoes;

  RegistroSaude({
    required this.id,
    required this.alunoId,
    required this.dataRegistro,
    this.pesoKg,
    this.alturaCm,
    this.pressaoArterial,
    this.glicemiaMgDl,
    this.observacoes,
  }) : imc = (pesoKg != null && alturaCm != null && alturaCm > 0)
      ? (pesoKg / ((alturaCm / 100) * (alturaCm / 100)))
      : null;
}

