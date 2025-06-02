enum TipoNotificacao {
  hidratacao,
  postura,
  meditacao,
  treino,
  geral
}

class Notificacao {
  final String id;
  final String titulo;
  final String mensagem;
  final TipoNotificacao tipo;
  final DateTime horario;
  bool ativa;


  Notificacao({
    required this.id,
    required this.titulo,
    required this.mensagem,
    required this.tipo,
    required this.horario,
    this.ativa = true,
  });
}



class Alerta {
  final String id;
  final String titulo;
  final String mensagem;
  final DateTime horario;
  final int frequenciaHoras;
  bool ativo;
  final String userId;

  Alerta({
    required this.id,
    required this.titulo,
    required this.mensagem,
    required this.horario,
    required this.frequenciaHoras,
    this.ativo = true,
    required this.userId,
  });
}

