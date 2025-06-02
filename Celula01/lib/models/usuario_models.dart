// Base User Model (Abstract)
enum TipoGenero { masculino, feminino, outro }

abstract class Usuario {
  final String id;
  final String nomeCompleto;
  final String email;
  // Password handling should be secure in a real app
  // For mock data, we might store it directly or omit it

  Usuario({
    required this.id,
    required this.nomeCompleto,
    required this.email,
  });
}

// Aluno Model
class Aluno extends Usuario {
  final DateTime dataNascimento;
  final TipoGenero genero;
  final double? peso;
  final double? altura;


  Aluno({
    required String id,
    required String nomeCompleto,
    required String email,
    required this.dataNascimento,
    required this.genero,
    this.peso,
    this.altura,
  }) : super(id: id, nomeCompleto: nomeCompleto, email: email);
}


class Especialista extends Usuario {
  final String areaAtuacao;
  final String crmCrn;
  final String bio;
  final String fotoUrl;


  Especialista({
    required String id,
    required String nomeCompleto,
    required String email,
    required this.areaAtuacao,
    required this.crmCrn,
    required this.bio,
    required this.fotoUrl,
  }) : super(id: id, nomeCompleto: nomeCompleto, email: email);
}

