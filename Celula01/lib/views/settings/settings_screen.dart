// views/settings/settings_screen.dart
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Mock state for notification toggles - replace with actual state management
  bool _postureNotifications = true;
  bool _hydrationNotifications = true;
  bool _meditationNotifications = true;

  // Helper to build section titles
  Widget _buildSectionTitle(String title, Color textColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textColor.withOpacity(0.8),
        ),
      ),
    );
  }

  // Helper to build settings list tiles
  Widget _buildSettingsTile(IconData icon, String title, String? subtitle, VoidCallback onTap, Color iconColor, Color textColor) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: textColor)),
      subtitle: subtitle != null ? Text(subtitle, style: TextStyle(color: textColor.withOpacity(0.7))) : null,
      trailing: Icon(Icons.chevron_right, color: textColor.withOpacity(0.5)),
      onTap: onTap,
    );
  }

  // Helper to build switch list tiles
  Widget _buildSwitchTile(IconData icon, String title, bool value, ValueChanged<bool> onChanged, Color iconColor, Color textColor, Color activeColor) {
    return SwitchListTile(
      secondary: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: textColor)),
      value: value,
      onChanged: onChanged,
      activeColor: activeColor,
    );
  }

  // Placeholder function for navigation/actions
  void _navigateTo(String routeName) {
    // In a real app, navigate using Navigator.pushNamed(context, routeName);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navegar para $routeName (Placeholder)')),
    );
    print('Navigate to $routeName');
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Saída'),
        content: const Text('Tem certeza que deseja sair da sua conta?'),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Sair', style: TextStyle(color: Theme.of(context).colorScheme.error)),
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              // TODO: Implement actual logout logic
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false); // Example logout navigation
              print('Logout confirmed');
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    final Color backgroundColor = Theme.of(context).colorScheme.background;
    final Color textColor = Theme.of(context).colorScheme.onSurface;
    final Color iconColor = primaryColor.withOpacity(0.8);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        backgroundColor: primaryColor,
        foregroundColor: onPrimaryColor,
      ),
      backgroundColor: backgroundColor,
      body: ListView(
        children: [
          _buildSectionTitle('Conta', textColor),
          _buildSettingsTile(Icons.person_outline, 'Editar Perfil', 'Nome, idade, objetivos', () => _navigateTo('/edit_profile'), iconColor, textColor),
          _buildSettingsTile(Icons.lock_outline, 'Alterar Senha', null, () => _navigateTo('/change_password'), iconColor, textColor),

          _buildSectionTitle('Notificações', textColor),
          _buildSwitchTile(Icons.accessibility_new, 'Lembretes de Postura', _postureNotifications, (value) {
            setState(() => _postureNotifications = value);
            // TODO: Save preference
          }, iconColor, textColor, primaryColor),
          _buildSwitchTile(Icons.water_drop_outlined, 'Lembretes de Hidratação', _hydrationNotifications, (value) {
            setState(() => _hydrationNotifications = value);
            // TODO: Save preference
          }, iconColor, textColor, primaryColor),
          _buildSwitchTile(Icons.self_improvement_outlined, 'Lembretes de Meditação', _meditationNotifications, (value) {
            setState(() => _meditationNotifications = value);
            // TODO: Save preference
          }, iconColor, textColor, primaryColor),
          // Add options for frequency/time later if needed

          _buildSectionTitle('Preferências', textColor),
          _buildSettingsTile(Icons.straighten_outlined, 'Unidades', 'kg, cm', () => _navigateTo('/preferences_units'), iconColor, textColor),
          // Add Theme (Light/Dark) or Language later if needed

          _buildSectionTitle('Sobre', textColor),
          _buildSettingsTile(Icons.privacy_tip_outlined, 'Política de Privacidade', null, () => _navigateTo('/privacy_policy'), iconColor, textColor),
          _buildSettingsTile(Icons.description_outlined, 'Termos de Serviço', null, () => _navigateTo('/terms_of_service'), iconColor, textColor),
          _buildSettingsTile(Icons.info_outline, 'Versão do App', '1.0.0', () {}, iconColor, textColor),

          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: OutlinedButton.icon(
              icon: Icon(Icons.logout, color: Theme.of(context).colorScheme.error),
              label: Text('Sair', style: TextStyle(color: Theme.of(context).colorScheme.error)),
              onPressed: _showLogoutConfirmation,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Theme.of(context).colorScheme.error.withOpacity(0.5)),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

