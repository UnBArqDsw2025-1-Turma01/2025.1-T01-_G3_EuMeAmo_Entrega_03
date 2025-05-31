// views/especialista/catalogo_profissionais_screen.dart
import 'package:flutter/material.dart';

class CatalogoProfissionaisScreen extends StatelessWidget {
  const CatalogoProfissionaisScreen({super.key});

  // Mock data for professionals
  final List<Map<String, dynamic>> mockProfissionais = const [
    {
      'nome': 'Dr. Carlos Alberto',
      'especialidade': 'Nutricionista Esportivo',
      'imagemUrl': null, // Placeholder for image URL
      'avaliacao': 4.8,
      'descricao': 'Especialista em dietas para atletas e performance.',
    },
    {
      'nome': 'Ana Paula Silva',
      'especialidade': 'Fisioterapeuta Ortopédica',
      'imagemUrl': null,
      'avaliacao': 4.9,
      'descricao': 'Foco em reabilitação de lesões e prevenção.',
    },
    {
      'nome': 'Pedro Henrique Souza',
      'especialidade': 'Personal Trainer',
      'imagemUrl': null,
      'avaliacao': 4.7,
      'descricao': 'Treinamento funcional e de força personalizado.',
    },
    {
      'nome': 'Mariana Costa',
      'especialidade': 'Psicóloga Clínica',
      'imagemUrl': null,
      'avaliacao': 5.0,
      'descricao': 'Apoio para saúde mental e bem-estar.',
    },
    {
      'nome': 'Ricardo Mendes',
      'especialidade': 'Educador Físico',
      'imagemUrl': null,
      'avaliacao': 4.6,
      'descricao': 'Planos de treino para iniciantes e avançados.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFB74C4C);
    const Color backgroundColor = Color(0xFFFDF3E7);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Catálogo de Profissionais'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: mockProfissionais.length,
        itemBuilder: (context, index) {
          final profissional = mockProfissionais[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[300],
                // Placeholder for image - replace with Image.network(profissional['imagemUrl']) if available
                child: Icon(Icons.person, size: 30, color: Colors.grey[600]),
              ),
              title: Text(profissional['nome'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(profissional['especialidade']),
                  const SizedBox(height: 4),
                  Text(profissional['descricao'], style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(profissional['avaliacao'].toString(), style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.chevron_right, color: primaryColor),
                onPressed: () {
                  // TODO: Implement navigation to professional details screen
                  print('Ver detalhes de ${profissional['nome']}');
                },
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}

