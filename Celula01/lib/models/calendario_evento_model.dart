// models/calendario_evento_model.dart

enum TipoEventoCalendario {
  treino,
  consulta,
  hidratacao,
  meditacao,
  outro
}

class CalendarioEvento {
  final String titulo;
  final DateTime data;
  final TipoEventoCalendario tipo;
  final String? descricao; // Opcional

  CalendarioEvento({
    required this.titulo,
    required this.data,
    this.tipo = TipoEventoCalendario.outro,
    this.descricao,
  });

  // Método para facilitar a criação a partir de um Map (ex: vindo de uma API)
  factory CalendarioEvento.fromMap(Map<String, dynamic> map) {
    return CalendarioEvento(
      titulo: map["titulo"] ?? "Evento sem título",
      data: map["data"] is DateTime ? map["data"] : DateTime.parse(map["data"] ?? DateTime.now().toIso8601String()),
      tipo: TipoEventoCalendario.values.firstWhere(
            (e) => e.toString() == "TipoEventoCalendario.${map["tipo"]}",
        orElse: () => TipoEventoCalendario.outro,
      ),
      descricao: map["descricao"],
    );
  }

  // Método para converter para Map (ex: para salvar em DB)
  Map<String, dynamic> toMap() {
    return {
      "titulo": titulo,
      "data": data.toIso8601String(),
      "tipo": tipo.toString().split(".").last, // Salva como string "treino", "consulta", etc.
      "descricao": descricao,
    };
  }

  @override
  String toString() => titulo; // Para exibição simples em listas
}

