enum TipoConteudo {
  exercicio,
  dicaPostura,
  video,
  podcast,
  artigo,
  meditacaoGuiada,
  receita, // Req 32 (Would)
  mitoVerdade, // Req 25 (Could)
  outro
}

class Conteudo {
  final String id;
  final String titulo;
  final String descricao;
  final TipoConteudo tipo;
  final String? url;
  final Duration? duracao;
  final String? beneficios;
  final String? instrucoes;
  final String? audioUrl;
  final List<String>? tags;
  final DateTime dataPostagem;
  bool isFavorito;

  Conteudo({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.tipo,
    this.url,
    this.duracao,
    this.beneficios,
    this.instrucoes,
    this.audioUrl,
    this.tags,
    required this.dataPostagem,
    this.isFavorito = false,
  });
}



