// models/estrategia_treino_corrigido.dart
import '../models/conteudo_models.dart';
import '../models/treino_models.dart';
import 'dart:math';

/// Interface estratégica para o padrão Strategy de montagem de treinos
abstract class EstrategiaMontarTreino {
  /// Gera uma lista de conteúdos (exercícios) para o treino
  List<Conteudo> gerarExercicios();

  /// Cria um novo treino com base na estratégia
  Treino criarTreino({
    required String alunoId,
    String? nome,
    String? metas,
    String? anotacoes,
  });

  /// Retorna o tipo de treino desta estratégia
  String get tipoTreino;

  /// Retorna a duração estimada para este tipo de treino
  Duration get duracaoEstimada;

  /// Retorna a frequência semanal recomendada para este tipo de treino
  int get frequenciaSemanal;
}

/// Estratégia concreta para treino de hipertrofia
class EstrategiaTreinoHipertrofia implements EstrategiaMontarTreino {
  @override
  List<Conteudo> gerarExercicios() {
    // Gera IDs únicos para os exercícios
    final String idBase = 'hipertrofia_${DateTime.now().millisecondsSinceEpoch}';

    return [
      Conteudo(
        id: '${idBase}_1',
        titulo: 'Supino Reto',
        descricao: '4 séries x 8 repetições',
        tipo: TipoConteudo.exercicio,
        instrucoes: 'Deite no banco, segure a barra com as mãos afastadas e empurre para cima.',
        beneficios: 'Fortalecimento do peitoral, ombros e tríceps.',
        duracao: Duration(minutes: 15),
        dataPostagem: DateTime.now(),
      ),
      Conteudo(
        id: '${idBase}_2',
        titulo: 'Agachamento Livre',
        descricao: '4 séries x 8 repetições',
        tipo: TipoConteudo.exercicio,
        instrucoes: 'Posicione a barra nos ombros, flexione os joelhos até 90 graus e retorne.',
        beneficios: 'Fortalecimento de quadríceps, glúteos e posterior de coxa.',
        duracao: Duration(minutes: 15),
        dataPostagem: DateTime.now(),
      ),
      Conteudo(
        id: '${idBase}_3',
        titulo: 'Remada Curvada',
        descricao: '4 séries x 8 repetições',
        tipo: TipoConteudo.exercicio,
        instrucoes: 'Segure a barra com as mãos, incline o tronco e puxe a barra até o abdômen.',
        beneficios: 'Fortalecimento das costas e bíceps.',
        duracao: Duration(minutes: 15),
        dataPostagem: DateTime.now(),
      ),
    ];
  }

  @override
  Treino criarTreino({
    required String alunoId,
    String? nome,
    String? metas,
    String? anotacoes,
  }) {
    final exercicios = gerarExercicios();
    final String id = 'treino_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(1000)}';

    return Treino(
      id: id,
      nome: nome ?? 'Treino de Hipertrofia',
      tipo: tipoTreino,
      tempoExecucaoEstimado: duracaoEstimada,
      frequenciaSemanal: frequenciaSemanal,
      metas: metas ?? 'Ganho de massa muscular',
      anotacoes: anotacoes,
      exercicios: exercicios,
      alunoId: alunoId,
    );
  }

  @override
  String get tipoTreino => 'Hipertrofia';

  @override
  Duration get duracaoEstimada => Duration(minutes: 60);

  @override
  int get frequenciaSemanal => 4;
}

/// Estratégia concreta para treino de emagrecimento
class EstrategiaTreinoEmagrecimento implements EstrategiaMontarTreino {
  @override
  List<Conteudo> gerarExercicios() {
    // Gera IDs únicos para os exercícios
    final String idBase = 'emagrecimento_${DateTime.now().millisecondsSinceEpoch}';

    return [
      Conteudo(
        id: '${idBase}_1',
        titulo: 'Burpee',
        descricao: '3 séries x 15 repetições',
        tipo: TipoConteudo.exercicio,
        instrucoes: 'Agache, apoie as mãos no chão, jogue as pernas para trás, faça uma flexão, volte à posição agachada e salte.',
        beneficios: 'Exercício completo que trabalha todo o corpo e aumenta o gasto calórico.',
        duracao: Duration(minutes: 10),
        dataPostagem: DateTime.now(),
      ),
      Conteudo(
        id: '${idBase}_2',
        titulo: 'Corrida na Esteira',
        descricao: '20 minutos em intensidade moderada a alta',
        tipo: TipoConteudo.exercicio,
        instrucoes: 'Mantenha uma velocidade desafiadora mas sustentável por 20 minutos.',
        beneficios: 'Melhora do condicionamento cardiovascular e queima de calorias.',
        duracao: Duration(minutes: 20),
        dataPostagem: DateTime.now(),
      ),
      Conteudo(
        id: '${idBase}_3',
        titulo: 'Mountain Climber',
        descricao: '3 séries x 20 repetições por perna',
        tipo: TipoConteudo.exercicio,
        instrucoes: 'Em posição de prancha, alterne trazendo os joelhos em direção ao peito rapidamente.',
        beneficios: 'Trabalha o core e aumenta a frequência cardíaca.',
        duracao: Duration(minutes: 10),
        dataPostagem: DateTime.now(),
      ),
    ];
  }

  @override
  Treino criarTreino({
    required String alunoId,
    String? nome,
    String? metas,
    String? anotacoes,
  }) {
    final exercicios = gerarExercicios();
    final String id = 'treino_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(1000)}';

    return Treino(
      id: id,
      nome: nome ?? 'Treino de Emagrecimento',
      tipo: tipoTreino,
      tempoExecucaoEstimado: duracaoEstimada,
      frequenciaSemanal: frequenciaSemanal,
      metas: metas ?? 'Perda de peso e queima de gordura',
      anotacoes: anotacoes,
      exercicios: exercicios,
      alunoId: alunoId,
    );
  }

  @override
  String get tipoTreino => 'Emagrecimento';

  @override
  Duration get duracaoEstimada => Duration(minutes: 45);

  @override
  int get frequenciaSemanal => 5;
}

/// Estratégia concreta para treino de manutenção
class EstrategiaTreinoManutencao implements EstrategiaMontarTreino {
  @override
  List<Conteudo> gerarExercicios() {
    // Gera IDs únicos para os exercícios
    final String idBase = 'manutencao_${DateTime.now().millisecondsSinceEpoch}';

    return [
      Conteudo(
        id: '${idBase}_1',
        titulo: 'Flexão',
        descricao: '3 séries x 12 repetições',
        tipo: TipoConteudo.exercicio,
        instrucoes: 'Apoie as mãos e os pés no chão, mantenha o corpo reto e flexione os cotovelos.',
        beneficios: 'Fortalecimento do peitoral, ombros e tríceps sem equipamentos.',
        duracao: Duration(minutes: 10),
        dataPostagem: DateTime.now(),
      ),
      Conteudo(
        id: '${idBase}_2',
        titulo: 'Abdominal',
        descricao: '3 séries x 15 repetições',
        tipo: TipoConteudo.exercicio,
        instrucoes: 'Deite-se de costas, flexione os joelhos e eleve o tronco em direção às pernas.',
        beneficios: 'Fortalecimento do core e definição abdominal.',
        duracao: Duration(minutes: 10),
        dataPostagem: DateTime.now(),
      ),
      Conteudo(
        id: '${idBase}_3',
        titulo: 'Caminhada',
        descricao: '30 minutos em ritmo moderado',
        tipo: TipoConteudo.exercicio,
        instrucoes: 'Mantenha um ritmo constante e confortável por 30 minutos.',
        beneficios: 'Manutenção do condicionamento cardiovascular e bem-estar geral.',
        duracao: Duration(minutes: 30),
        dataPostagem: DateTime.now(),
      ),
    ];
  }

  @override
  Treino criarTreino({
    required String alunoId,
    String? nome,
    String? metas,
    String? anotacoes,
  }) {
    final exercicios = gerarExercicios();
    final String id = 'treino_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(1000)}';

    return Treino(
      id: id,
      nome: nome ?? 'Treino de Manutenção',
      tipo: tipoTreino,
      tempoExecucaoEstimado: duracaoEstimada,
      frequenciaSemanal: frequenciaSemanal,
      metas: metas ?? 'Manutenção da forma física e saúde geral',
      anotacoes: anotacoes,
      exercicios: exercicios,
      alunoId: alunoId,
    );
  }

  @override
  String get tipoTreino => 'Manutenção';

  @override
  Duration get duracaoEstimada => Duration(minutes: 50);

  @override
  int get frequenciaSemanal => 3;
}
