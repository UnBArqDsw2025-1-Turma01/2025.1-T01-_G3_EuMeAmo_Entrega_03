// views/help/help_screen.dart
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  // Mock FAQ Data based on the image provided
  final List<Map<String, String>> faqData = const [
    {
      'question': 'Como cadastro meu perfil?',
      'answer': 'Na tela inicial, clique em "Cadastre-se" e siga as instruções para criar seu perfil de usuário comum ou especialista.',
    },
    {
      'question': 'Como configuro os lembretes de hidratação?',
      'answer': 'Vá até a tela de Configurações (ícone de engrenagem), na seção "Notificações", e ative os "Lembretes de Hidratação". Você poderá ajustar os horários em futuras versões.',
    },
    {
      'question': 'Onde encontro os exercícios de postura?',
      'answer': 'Os exercícios de postura e bem-estar físico estarão disponíveis na seção "Exercícios" (ainda em desenvolvimento).',
    },
    {
      'question': 'Como funciona a comunidade?',
      'answer': 'Na seção "Comunidade", você pode ver postagens de outros usuários, curtir e, futuramente, comentar e compartilhar suas próprias experiências e dicas.',
    },
    {
      'question': 'Como registrar meus dados de saúde?',
      'answer': 'A funcionalidade de registro de dados de saúde (peso, altura, etc.) estará disponível na seção "Saúde Pessoal" em breve.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color textColor = Theme.of(context).colorScheme.onSurface;
    final Color cardBackgroundColor = Theme.of(context).colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajuda e Suporte'),
        backgroundColor: primaryColor, // Match the header in the image
        foregroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          tooltip: 'Voltar',
          onPressed: () {
            // Ensure we are using the correct navigator context and it can pop
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              // Fallback or error handling if it cannot pop (e.g., root screen)
              print("Cannot pop HelpScreen context");
              // Optionally, navigate to a default screen like dashboard if needed
              // Navigator.pushReplacementNamed(context, '/dashboard');
            }
          },
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // FAQ Section
          Text(
            'Perguntas Frequentes (FAQ)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 12),
          Card(
            color: cardBackgroundColor,
            elevation: 0, // Remove card elevation if needed to match image
            margin: EdgeInsets.zero, // Remove card margin
            shape: RoundedRectangleBorder( // Add border if needed
              // side: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: faqData.map((item) {
                return ExpansionTile(
                  iconColor: textColor.withOpacity(0.6),
                  collapsedIconColor: textColor.withOpacity(0.6),
                  shape: const Border(), // Remove internal border
                  collapsedShape: const Border(), // Remove internal border
                  title: Text(
                    item['question']!,
                    style: TextStyle(fontWeight: FontWeight.w500, color: textColor),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                      child: Text(
                        item['answer']!,
                        style: TextStyle(color: textColor.withOpacity(0.8)),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),

          // Contact Section
          Text(
            'Fale Conosco',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 12),
          Card(
            color: cardBackgroundColor,
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              // side: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.email_outlined, color: textColor.withOpacity(0.7)),
                  title: Text('Enviar E-mail para Suporte', style: TextStyle(color: textColor)),
                  trailing: Icon(Icons.open_in_new, size: 18, color: textColor.withOpacity(0.7)),
                  onTap: () {
                    // TODO: Implement email sending using url_launcher
                    print('Navigate to email client');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Funcionalidade de envio de e-mail ainda não implementada.')),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.web_outlined, color: textColor.withOpacity(0.7)),
                  title: Text('Visite nosso Site (em breve)', style: TextStyle(color: textColor)),
                  trailing: Icon(Icons.open_in_new, size: 18, color: textColor.withOpacity(0.7)),
                  onTap: () {
                    // TODO: Implement opening website URL using url_launcher
                    print('Navigate to website');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Link para o site ainda não disponível.')),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

