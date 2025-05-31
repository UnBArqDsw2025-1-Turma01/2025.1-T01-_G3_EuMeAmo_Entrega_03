// views/alimentacao/ficha_dieta_screen.dart
import 'package:flutter/material.dart';

class FichaDietaScreen extends StatelessWidget {
  const FichaDietaScreen({super.key});

  // Mock data for diet sheet
  final Map<String, List<Map<String, String>>> mockDieta = const {
    'Café da Manhã (07:00)': [
      {'alimento': 'Ovos Mexidos', 'quantidade': '3 unidades', 'obs': 'Com temperos a gosto'},
      {'alimento': 'Pão Integral', 'quantidade': '2 fatias', 'obs': 'Com pasta de amendoim'},
      {'alimento': 'Fruta', 'quantidade': '1 porção', 'obs': 'Mamão ou Banana'},
    ],
    'Lanche da Manhã (10:00)': [
      {'alimento': 'Iogurte Natural', 'quantidade': '1 pote (170g)', 'obs': 'Com granola sem açúcar'},
      {'alimento': 'Castanhas', 'quantidade': '30g', 'obs': 'Mix de oleaginosas'},
    ],
    'Almoço (13:00)': [
      {'alimento': 'Frango Grelhado', 'quantidade': '150g', 'obs': '-'},
      {'alimento': 'Arroz Integral', 'quantidade': '4 colheres de sopa', 'obs': '-'},
      {'alimento': 'Feijão', 'quantidade': '1 concha', 'obs': '-'},
      {'alimento': 'Salada Colorida', 'quantidade': 'À vontade', 'obs': 'Folhas, legumes crus'},
      {'alimento': 'Azeite Extra Virgem', 'quantidade': '1 colher de sopa', 'obs': 'Para temperar a salada'},
    ],
    'Lanche da Tarde (16:00)': [
      {'alimento': 'Whey Protein', 'quantidade': '1 scoop (30g)', 'obs': 'Misturado com água'},
      {'alimento': 'Fruta', 'quantidade': '1 porção', 'obs': 'Maçã ou Pera'},
    ],
    'Jantar (19:00)': [
      {'alimento': 'Salmão Assado', 'quantidade': '150g', 'obs': '-'},
      {'alimento': 'Batata Doce Cozida', 'quantidade': '150g', 'obs': '-'},
      {'alimento': 'Brócolis no Vapor', 'quantidade': 'À vontade', 'obs': '-'},
    ],
    'Ceia (22:00)': [
      {'alimento': 'Ovos Cozidos', 'quantidade': '2 unidades', 'obs': 'Opcional, se sentir fome'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFB74C4C);
    const Color secondaryColor = Color(0xFF8DC63F); // Green for diet
    const Color backgroundColor = Color(0xFFFDF3E7);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Ficha de Dieta Completa'),
        backgroundColor: secondaryColor, // Use green for diet theme
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: mockDieta.keys.length,
        itemBuilder: (context, index) {
          final refeicaoNome = mockDieta.keys.elementAt(index);
          final alimentos = mockDieta[refeicaoNome]!;

          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ExpansionTile(
              leading: const Icon(Icons.restaurant_menu, color: secondaryColor),
              title: Text(refeicaoNome, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              initiallyExpanded: index == 0 || index == 2, // Expand breakfast and lunch initially
              children: alimentos.map((al) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(al['alimento']!, style: const TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(al['quantidade']!, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(al['obs']!, style: TextStyle(fontSize: 12, color: Colors.grey[600], fontStyle: FontStyle.italic)),
                      ),
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

