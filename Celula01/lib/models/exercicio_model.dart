// models/exercicio_model.dart
class Exercicio {
  final String nome;
  final int? series;
  final int? repeticoes;
  final String? duracao;

  Exercicio({
    required this.nome,
    this.series,
    this.repeticoes,
    this.duracao
  });

  @override
  String toString() {
    if (duracao != null) {
      return '$nome - Duração: $duracao';
    } else {
      return '$nome - $series séries x $repeticoes repetições';
    }
  }
}
