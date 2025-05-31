class Refeicao {
  final String id;
  final String nome; // e.g., Café da Manhã, Almoço, Lanche
  final String horarioRecomendado; // e.g., "08:00"
  final List<String> alimentos;
  final String? observacoes;
  final double? caloriasEstimadas;

  Refeicao({
    required this.id,
    required this.nome,
    required this.horarioRecomendado,
    required this.alimentos,
    this.observacoes,
    this.caloriasEstimadas,
  });
}

class PlanoAlimentar {
  final String id;
  final String alunoId;
  final String especialistaId;
  final DateTime dataInicio;
  final DateTime? dataFim;
  final List<Refeicao> refeicoesDiarias;
  final String? objetivo;
  final String? recomendacoesGerais;

  PlanoAlimentar({
    required this.id,
    required this.alunoId,
    required this.especialistaId,
    required this.dataInicio,
    this.dataFim,
    required this.refeicoesDiarias,
    this.objetivo,
    this.recomendacoesGerais,
  });
}

// Mock data repository would provide instances of this class

