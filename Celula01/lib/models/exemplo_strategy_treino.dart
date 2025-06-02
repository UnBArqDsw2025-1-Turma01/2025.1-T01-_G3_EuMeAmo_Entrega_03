// exemplos/exemplo_strategy_treino_corrigido.dart
import '../models/estrategia_treino.dart';
import '../models/treino_models.dart';

/// Exemplo de uso do padrão Strategy para montagem de treinos
void main() {
  print('🏋️ DEMONSTRAÇÃO DO PADRÃO STRATEGY PARA TREINOS 🏋️');
  print('------------------------------------------------');

  // ID do aluno para os exemplos
  final String alunoId = 'aluno123';

  // Criando treino com estratégia de hipertrofia
  print('\n1️⃣ Criando treino com estratégia de hipertrofia:');
  final estrategiaHipertrofia = EstrategiaTreinoHipertrofia();
  final treinoHipertrofia = estrategiaHipertrofia.criarTreino(
    alunoId: alunoId,
    nome: 'Treino A - Hipertrofia',
    metas: 'Ganho de massa muscular',
    anotacoes: 'Descanso de 60 segundos entre séries',
  );

  // Exibindo detalhes do treino
  _mostrarDetalhesTreino(treinoHipertrofia);

  // Criando treino com estratégia de emagrecimento
  print('\n2️⃣ Criando treino com estratégia de emagrecimento:');
  final estrategiaEmagrecimento = EstrategiaTreinoEmagrecimento();
  final treinoEmagrecimento = estrategiaEmagrecimento.criarTreino(
    alunoId: alunoId,
    nome: 'Treino B - Emagrecimento',
    metas: 'Perda de 5kg em 2 meses',
  );

  // Exibindo detalhes do treino
  _mostrarDetalhesTreino(treinoEmagrecimento);

  // Alterando a estratégia para um novo treino
  print('\n3️⃣ Criando novo treino com estratégia de manutenção:');
  final estrategiaManutencao = EstrategiaTreinoManutencao();
  final treinoManutencao = estrategiaManutencao.criarTreino(
    alunoId: alunoId,
    nome: 'Treino de Manutenção',
    metas: 'Manter condicionamento físico',
  );

  // Exibindo detalhes do treino
  _mostrarDetalhesTreino(treinoManutencao);

  print('\n✅ Demonstração concluída!');
}

/// Função auxiliar para exibir detalhes do treino
void _mostrarDetalhesTreino(Treino treino) {
  print('📋 Detalhes do Treino: ${treino.nome}');
  print('📝 Tipo: ${treino.tipo}');
  print('⏱️ Duração estimada: ${treino.tempoExecucaoEstimado.inMinutes} minutos');
  print('🔄 Frequência semanal: ${treino.frequenciaSemanal}x por semana');

  if (treino.metas != null) {
    print('🎯 Metas: ${treino.metas}');
  }

  if (treino.anotacoes != null) {
    print('📝 Anotações: ${treino.anotacoes}');
  }

  print('Exercícios:');
  for (var exercicio in treino.exercicios) {
    print('- ${exercicio.titulo}: ${exercicio.descricao}');
    if (exercicio.duracao != null) {
      print('  ⏱️ Duração: ${exercicio.duracao!.inMinutes} minutos');
    }
  }
}
