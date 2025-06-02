// views/home/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:projetoeumeamo/views/notificacoes/notificacoes_modal.dart';

// Importando o modal de notificações


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Use DateFormat for the date
  final String formattedDate = DateFormat('dd \'de\' MMMM \'de\' yyyy', 'pt_BR').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    // Define colors based on the theme or prototype
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color secondaryColor = Theme.of(context).colorScheme.secondary;
    final Color backgroundColor = Theme.of(context).colorScheme.background;
    final Color cardBackgroundColor = Theme.of(context).colorScheme.surface;
    final Color textColor = Theme.of(context).colorScheme.onSurface; // Use theme text color
    final Color accentColor1 = Colors.pink.shade300; // Example color for chart
    final Color accentColor2 = Colors.blue.shade300; // Example color for chart
    final Color accentColor3 = Colors.orange.shade300; // Example color for chart

    // Get screen size for responsive layout
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;
    final bool isMediumScreen = screenSize.width >= 600 && screenSize.width < 1200;

    return Scaffold(
      backgroundColor: backgroundColor,
      // Use drawer for mobile layout instead of fixed sidebar
      drawer: isSmallScreen ? _buildDrawer(context, primaryColor) : null,
      appBar: isSmallScreen
          ? AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text('EuMeAmo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => _showNotificacoesModal(context),
          ),
        ],
      )
          : null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (isSmallScreen) {
            // Mobile layout
            return _buildMobileLayout(
              context,
              primaryColor,
              secondaryColor,
              backgroundColor,
              cardBackgroundColor,
              textColor,
              accentColor1,
              accentColor2,
              accentColor3,
            );
          } else {
            // Tablet/Desktop layout
            return _buildDesktopLayout(
              context,
              primaryColor,
              secondaryColor,
              backgroundColor,
              cardBackgroundColor,
              textColor,
              accentColor1,
              accentColor2,
              accentColor3,
              isMediumScreen,
            );
          }
        },
      ),
    );
  }

  // Método para exibir o modal de notificações
  void _showNotificacoesModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const NotificacoesModal();
      },
    );
  }

  // --- Responsive Layout Methods ---

  Widget _buildMobileLayout(
      BuildContext context,
      Color primaryColor,
      Color secondaryColor,
      Color backgroundColor,
      Color cardBackgroundColor,
      Color textColor,
      Color accentColor1,
      Color accentColor2,
      Color accentColor3,
      ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Olá, Fulano!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor)),
                Text('Informações Gerais',
                    style: TextStyle(fontSize: 16, color: textColor.withOpacity(0.7))),
                Text(formattedDate,
                    style: TextStyle(fontSize: 14, color: textColor.withOpacity(0.7))),
              ],
            ),
            const SizedBox(height: 24),

            // Training Card
            _buildTrainingCard(cardBackgroundColor, textColor),
            const SizedBox(height: 16),

            // Diet Card
            _buildDietCard(cardBackgroundColor, textColor),
            const SizedBox(height: 16),

            // Workout Time Card
            _buildWorkoutTimeCard(primaryColor),
            const SizedBox(height: 24),

            // Activity Report Card
            _buildActivityReportCard(accentColor1, accentColor2, accentColor3, cardBackgroundColor, textColor),
            const SizedBox(height: 24),

            // Daily Challenge Card
            _buildDailyChallengeCard(cardBackgroundColor, textColor, secondaryColor),
            const SizedBox(height: 24),

            // IMC Calculator Card
            _buildImcCalculatorCard(cardBackgroundColor, textColor, secondaryColor),
            const SizedBox(height: 16),

            // Professional Catalog Card
            _buildProfessionalCatalogCard(cardBackgroundColor, textColor),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(
      BuildContext context,
      Color primaryColor,
      Color secondaryColor,
      Color backgroundColor,
      Color cardBackgroundColor,
      Color textColor,
      Color accentColor1,
      Color accentColor2,
      Color accentColor3,
      bool isMediumScreen,
      ) {
    return Row(
      children: [
        // Left Sidebar Navigation
        _buildLeftSidebar(context, primaryColor),

        // Main Content Area
        Expanded(
          flex: 3, // Adjust flex factor as needed
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Notification Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Olá, Fulano!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor)),
                        Text('Informações Gerais', style: TextStyle(fontSize: 16, color: textColor.withOpacity(0.7))),
                        Text(formattedDate, style: TextStyle(fontSize: 14, color: textColor.withOpacity(0.7))),
                      ],
                    ),
                    // Notification Button
                    Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.notifications, color: Colors.white),
                        tooltip: 'Notificações',
                        onPressed: () {
                          _showNotificacoesModal(context);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Main Cards Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildTrainingCard(cardBackgroundColor, textColor)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildDietCard(cardBackgroundColor, textColor)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildWorkoutTimeCard(primaryColor)),
                  ],
                ),
                const SizedBox(height: 24),

                // Activity Report Card
                _buildActivityReportCard(accentColor1, accentColor2, accentColor3, cardBackgroundColor, textColor),
                const SizedBox(height: 24),

                // Daily Challenge Card
                _buildDailyChallengeCard(cardBackgroundColor, textColor, secondaryColor),
              ],
            ),
          ),
        ),

        // Right Sidebar (hide on medium screens)
        if (!isMediumScreen) _buildRightSidebar(context, cardBackgroundColor, textColor, secondaryColor),
      ],
    );
  }

  // --- Widget Building Methods ---

  Widget _buildDrawer(BuildContext context, Color primaryColor) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.favorite, color: Colors.white, size: 40),
                const SizedBox(height: 12),
                const Text(
                  'EuMeAmo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Text(
                  'Cuide de você, ame-se mais.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            selected: true,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Calendário'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/calendario');
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat_bubble_outline),
            title: const Text('Comunidade'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/comunidade');
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Relatório de Atividades'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/relatorio_atividades');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Ajuda'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/help');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLeftSidebar(BuildContext context, Color primaryColor) {
    return Container(
      width: 80, // Adjust width as needed
      color: Colors.white, // Sidebar background color
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Icon(Icons.favorite, color: primaryColor, size: 40), // Placeholder Logo
          // Navigation Icons
          Column(
            children: [
              _buildSidebarIcon(Icons.dashboard, true, primaryColor, () {
                // Already on dashboard, do nothing or refresh?
                print('Dashboard selected');
              }), // Dashboard (selected)
              _buildSidebarIcon(Icons.calendar_today, false, primaryColor, () {
                Navigator.pushNamed(context, '/calendario');
              }),
              _buildSidebarIcon(Icons.chat_bubble_outline, false, primaryColor, () {
                Navigator.pushNamed(context, '/comunidade');
              }),
              _buildSidebarIcon(Icons.bar_chart, false, primaryColor, () {
                Navigator.pushNamed(context, '/relatorio_atividades');
              }),
              _buildSidebarIcon(Icons.settings, false, primaryColor, () {
                Navigator.pushNamed(context, '/settings');
              }),
            ],
          ),
          // Bottom Icons
          Column(
            children: [
              _buildSidebarIcon(Icons.logout, false, primaryColor, () {
                Navigator.pushReplacementNamed(context, '/login');
              }),
              _buildSidebarIcon(Icons.help_outline, false, primaryColor, () {
                Navigator.pushNamed(context, '/help');
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarIcon(IconData icon, bool isSelected, Color primaryColor, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, color: isSelected ? primaryColor : Colors.grey.shade600, size: 28),
      onPressed: onPressed,
      tooltip: '', // Add tooltips later
      padding: const EdgeInsets.symmetric(vertical: 16.0),
    );
  }

  Widget _buildTrainingCard(Color bgColor, Color textColor) {
    return Card(
      color: bgColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/ficha_treino'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.fitness_center, color: textColor.withOpacity(0.8)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text('Ficha de treino',
                      style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('Segunda: Peito, Supino, Supino...',
                style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.7)),
                overflow: TextOverflow.ellipsis,
              ),
              Text('Terça: Costa, Puxada...',
                style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.7)),
                overflow: TextOverflow.ellipsis,
              ),
              Text('Quarta: Perna, Agachamento...',
                style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.7)),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDietCard(Color bgColor, Color textColor) {
    return Card(
      color: bgColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/ficha_dieta'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.restaurant_menu, color: textColor.withOpacity(0.8)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text('Ficha de dieta',
                      style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('Café: Ovos, Frutas, Pão...',
                style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.7)),
                overflow: TextOverflow.ellipsis,
              ),
              Text('Almoço: Frango, Salada...',
                style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.7)),
                overflow: TextOverflow.ellipsis,
              ),
              Text('Jantar: Peixe, Legumes...',
                style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.7)),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutTimeCard(Color primaryColor) {
    return Card(
      color: primaryColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('30', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white)),
              Text('minutos', style: TextStyle(fontSize: 16, color: Colors.white70)),
              Text('para musculação.', style: TextStyle(fontSize: 14, color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityReportCard(Color c1, Color c2, Color c3, Color bgColor, Color textColor) {
    return Card(
      color: bgColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/relatorio_atividades'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text('Relatório de atividades',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownButton<String>(
                    value: 'Jan 2026',
                    underline: Container(),
                    icon: Icon(Icons.arrow_drop_down, size: 18, color: textColor.withOpacity(0.7)),
                    style: TextStyle(color: textColor, fontSize: 12),
                    dropdownColor: bgColor,
                    items: ['Jan 2026', 'Dez 2025', 'Nov 2025']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) { print('Month changed'); },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Placeholder for the chart
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(child: Text('Gráfico de Atividades (Placeholder)',
                  style: TextStyle(color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                )),
              ),
              const SizedBox(height: 16),
              // Legend - Wrap for small screens
              Wrap(
                spacing: 16,
                runSpacing: 8,
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  _buildLegendItem(c1, 'Musculação', textColor),
                  _buildLegendItem(c2, 'Jiu-Jitsu', textColor),
                  _buildLegendItem(c3, 'Natação', textColor),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text, Color textColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 10, color: color),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.8))),
      ],
    );
  }

  Widget _buildRightSidebar(BuildContext context, Color cardBgColor, Color textColor, Color accentColor) {
    return Container(
      width: 280,
      color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            _buildImcCalculatorCard(cardBgColor, textColor, accentColor),
            const SizedBox(height: 20),
            _buildProfessionalCatalogCard(cardBgColor, textColor),
            const SizedBox(height: 20),
            _buildDailyChallengeCard(cardBgColor, textColor, accentColor)
          ],
        ),
      ),
    );
  }

  Widget _buildImcCalculatorCard(Color bgColor, Color textColor, Color accentColor) {
    final Color cardTextColor = textColor;

    return Card(
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Calculadora de IMC',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: cardTextColor),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: Text('Altura',
                  style: TextStyle(fontSize: 12, color: cardTextColor.withOpacity(0.7)),
                )),
                Text('180 cm',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: cardTextColor),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(child: Text('Peso',
                  style: TextStyle(fontSize: 12, color: cardTextColor.withOpacity(0.7)),
                )),
                Text('70 kg',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: cardTextColor),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Divider(color: cardTextColor.withOpacity(0.2)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text('Índice de massa corporal',
                    style: TextStyle(fontSize: 12, color: cardTextColor.withOpacity(0.7)),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text('21.6',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: cardTextColor),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Center(
              child: ElevatedButton(
                onPressed: () { print('IMC details'); },
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text('Peso saudável!', style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessionalCatalogCard(Color bgColor, Color textColor) {
    return Card(
      color: bgColor,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/catalogo_profissionais'),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Catálogo de Profissionais',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text('Encontre nutricionistas, personal trainers e mais.',
                style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.7)),
              ),
              const SizedBox(height: 12),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/catalogo_profissionais'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text('Ver catálogo', style: TextStyle(fontSize: 12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDailyChallengeCard(Color bgColor, Color textColor, Color accentColor) {
    return Card(
      color: bgColor,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/desafio_diario'),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.emoji_events, color: Colors.green.shade400, size: 24),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text('Desafio do dia!',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text('Complete 30 minutos de cardio hoje.',
                      style: TextStyle(fontSize: 14, color: textColor.withOpacity(0.8)),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 14, color: textColor.withOpacity(0.6)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
