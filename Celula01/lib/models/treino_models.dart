import 'conteudo_models.dart'; // Assuming Conteudo model exists for exercises

class Treino {
  final String id;
  final String nome;
  final String tipo; // e.g., Força, Cardio, Flexibilidade
  final Duration tempoExecucaoEstimado;
  final int frequenciaSemanal;
  final String? metas;
  final String? anotacoes;
  final List<Conteudo> exercicios; // Link to specific exercises/content
  final String alunoId; // Link to the student

  Treino({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.tempoExecucaoEstimado,
    required this.frequenciaSemanal,
    this.metas,
    this.anotacoes,
    required this.exercicios,
    required this.alunoId,
  });
}

// Mock data repository/service would provide instances of this class

