// views/treino/ficha_treino_screen.dart
import 'package:flutter/material.dart';

class FichaTreinoScreen extends StatelessWidget {
  const FichaTreinoScreen({super.key});

  // Mock data for training sheet
  final Map<String, List<Map<String, String>>> mockTreino = const {
    'Segunda': [
      {'exercicio': 'Supino Reto', 'series': '3', 'repeticoes': '10-12', 'descanso': '60s'},
      {'exercicio': 'Crucifixo Inclinado', 'series': '3', 'repeticoes': '12-15', 'descanso': '60s'},
      {'exercicio': 'Desenvolvimento Militar', 'series': '3', 'repeticoes': '10', 'descanso': '75s'},
      {'exercicio': 'Elevação Lateral', 'series': '4', 'repeticoes': '15', 'descanso': '45s'},
    ],
    'Terça': [
      {'exercicio': 'Agachamento Livre', 'series': '4', 'repeticoes': '8-10', 'descanso': '90s'},
      {'exercicio': 'Leg Press 45', 'series': '3', 'repeticoes': '12', 'descanso': '75s'},
      {'exercicio': 'Cadeira Extensora', 'series': '3', 'repeticoes': '15', 'descanso': '60s'},
      {'exercicio': 'Mesa Flexora', 'series': '3', 'repeticoes': '12', 'descanso': '60s'},
    ],
    'Quarta': [
      {'exercicio': 'Descanso Ativo', 'series': '-', 'repeticoes': 'Caminhada Leve 30min', 'descanso': '-'},
    ],
    'Quinta': [
      {'exercicio': 'Barra Fixa', 'series': '3', 'repeticoes': 'Falha', 'descanso': '75s'},
      {'exercicio': 'Remada Curvada', 'series': '3', 'repeticoes': '10', 'descanso': '75s'},
      {'exercicio': 'Puxada Alta', 'series': '3', 'repeticoes': '12', 'descanso': '60s'},
      {'exercicio': 'Rosca Direta', 'series': '3', 'repeticoes': '12', 'descanso': '60s'},
    ],
    'Sexta': [
      {'exercicio': 'Supino Reto', 'series': '3', 'repeticoes': '10-12', 'descanso': '60s'},
      {'exercicio': 'Crucifixo Inclinado', 'series': '3', 'repeticoes': '12-15', 'descanso': '60s'},
      {'exercicio': 'Desenvolvimento Militar', 'series': '3', 'repeticoes': '10', 'descanso': '75s'},
      {'exercicio': 'Elevação Lateral', 'series': '4', 'repeticoes': '15', 'descanso': '45s'},
    ],
    'Sábado': [
      {'exercicio': 'Descanso', 'series': '-', 'repeticoes': '-', 'descanso': '-'},
    ],
    'Domingo': [
      {'exercicio': 'Descanso', 'series': '-', 'repeticoes': '-', 'descanso': '-'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFB74C4C);
    const Color backgroundColor = Color(0xFFFDF3E7);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Ficha de Treino Completa'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: mockTreino.keys.length,
        itemBuilder: (context, index) {
          final dia = mockTreino.keys.elementAt(index);
          final exercicios = mockTreino[dia]!;

          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ExpansionTile(
              title: Text(dia, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              children: exercicios.map((ex) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ex['exercicio']!, style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Séries: ${ex['series']}', style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                          Text('Repetições: ${ex['repeticoes']}', style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                          Text('Descanso: ${ex['descanso']}', style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                      if (index < exercicios.length - 1) const Divider(height: 16),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

