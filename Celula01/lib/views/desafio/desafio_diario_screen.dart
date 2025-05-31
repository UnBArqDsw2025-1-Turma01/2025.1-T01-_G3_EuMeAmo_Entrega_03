// views/desafio/desafio_diario_screen.dart
import 'package:flutter/material.dart';

class DesafioDiarioScreen extends StatelessWidget {
  const DesafioDiarioScreen({super.key});

  // Mock data for the daily challenge
  final Map<String, dynamic> mockDesafio = const {
    'titulo': 'Desafio de Hidratação - Dia 3',
    'data': '11 de Abril de 2026',
    'descricao':
    'Hoje o desafio é simples, mas fundamental: beber pelo menos 2,5 litros de água ao longo do dia! A hidratação adequada melhora a disposição, a pele e o funcionamento do corpo.',
    'meta': '2500 ml',
    'progresso_atual': 1200, // Mock progress in ml
    'dicas': [
      'Tenha sempre uma garrafa de água por perto.',
      'Estabeleça horários para beber água (ex: ao acordar, antes das refeições).',
      'Use aplicativos de lembrete, se necessário.',
      'Consuma frutas ricas em água, como melancia e melão.',
    ],
    'concluido': false,
  };

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFB74C4C);
    const Color secondaryColor = Color(0xFFFFA726); // Orange for challenge theme
    const Color backgroundColor = Color(0xFFFDF3E7);
    final double progressoPercentual =
    (mockDesafio['progresso_atual'] / 2500).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(mockDesafio['titulo']),
        backgroundColor: secondaryColor,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mockDesafio['data'],
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 16),
            Text(
              mockDesafio['descricao'],
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 24),
            Text(
              'Sua Meta: ${mockDesafio['meta']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Progresso Atual: ${mockDesafio['progresso_atual']} ml',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progressoPercentual,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(secondaryColor),
              minHeight: 10,
            ),
            const SizedBox(height: 24),
            const Text(
              'Dicas para Concluir:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...mockDesafio['dicas'].map<Widget>((dica) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_outline, size: 18, color: secondaryColor),
                    const SizedBox(width: 8),
                    Expanded(child: Text(dica)),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(mockDesafio['concluido'] ? Icons.check_circle : Icons.radio_button_unchecked),
                label: Text(mockDesafio['concluido'] ? 'Desafio Concluído!' : 'Marcar como Concluído'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: mockDesafio['concluido'] ? Colors.grey : secondaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: mockDesafio['concluido'] ? null : () {
                  // TODO: Implement logic to mark challenge as completed
                  print('Marcar desafio como concluído');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

