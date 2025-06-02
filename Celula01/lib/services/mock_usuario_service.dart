import '../models/usuario_models.dart';

// Mock Service/Repository for User data
class MockUsuarioService {
  // Mock data - replace with more realistic data as needed
  final List<Aluno> _alunos = [
    Aluno(
      id: 'aluno1',
      nomeCompleto: 'João Silva',
      email: 'joao.silva@email.com',
      dataNascimento: DateTime(1995, 3, 15),
      genero: TipoGenero.masculino,
      peso: 75.5,
      altura: 178.0,
    ),
    Aluno(
      id: 'aluno2',
      nomeCompleto: 'Maria Oliveira',
      email: 'maria.oliveira@email.com',
      dataNascimento: DateTime(1998, 7, 22),
      genero: TipoGenero.feminino,
      peso: 62.0,
      altura: 165.0,
    ),
  ];

  final List<Especialista> _especialistas = [
    Especialista(
      id: 'esp1',
      nomeCompleto: 'Dr. Carlos Andrade',
      email: 'carlos.andrade@email.com',
      areaAtuacao: 'Nutrição Esportiva',
      crmCrn: 'CRN-SP 12345',
      bio: 'Nutricionista focado em performance e saúde.',
      fotoUrl: 'https://via.placeholder.com/150/FF0000',
    ),
    Especialista(
      id: 'esp2',
      nomeCompleto: 'Dra. Ana Souza',
      email: 'ana.souza@email.com',
      areaAtuacao: 'Fisioterapia Postural',
      crmCrn: 'CREFITO 54321',
      bio: 'Especialista em correção postural e bem-estar físico.',
      fotoUrl: 'https://via.placeholder.com/150/0000FF',
    ),
  ];

  // Mock authentication
  Future<Usuario?> login(String email, String senha) async {
    // In a real app, verify password hash
    // Mock logic: find user by email, ignore password for now
    try {
      return _alunos.firstWhere((a) => a.email == email);
    } catch (e) {
      try {
        return _especialistas.firstWhere((esp) => esp.email == email);
      } catch (e) {
        return null; // User not found
      }
    }
  }

  Future<Aluno?> getAlunoById(String id) async {
    try {
      return _alunos.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<Especialista?> getEspecialistaById(String id) async {
    try {
      return _especialistas.firstWhere((esp) => esp.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<Especialista>> getTodosEspecialistas() async {
    return _especialistas;
  }

  Future<bool> cadastrarAluno(Aluno novoAluno) async {
    // Mock logic: check for email conflict, then add
    if (_alunos.any((a) => a.email == novoAluno.email) || _especialistas.any((esp) => esp.email == novoAluno.email)) {
      return false; // Email already exists
    }
    _alunos.add(novoAluno);
    return true;
  }

  Future<bool> cadastrarEspecialista(Especialista novoEspecialista) async {
    if (_alunos.any((a) => a.email == novoEspecialista.email) || _especialistas.any((esp) => esp.email == novoEspecialista.email)) {
      return false; // Email already exists
    }
    _especialistas.add(novoEspecialista);
    return true;
  }

// Add methods for updating profiles, etc.
}

