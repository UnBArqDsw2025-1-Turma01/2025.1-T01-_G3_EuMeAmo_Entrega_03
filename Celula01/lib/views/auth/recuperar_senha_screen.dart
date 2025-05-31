// Views/auth/recuperar_senha_screen.dart
import 'package:flutter/material.dart';

class RecuperarSenhaScreen extends StatefulWidget {
  const RecuperarSenhaScreen({super.key});

  @override
  State<RecuperarSenhaScreen> createState() => _RecuperarSenhaScreenState();
}

class _RecuperarSenhaScreenState extends State<RecuperarSenhaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _novaSenhaController = TextEditingController();
  final _confirmarNovaSenhaController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _novaSenhaController.dispose();
    _confirmarNovaSenhaController.dispose();
    super.dispose();
  }

  void _trocarSenha() {
    if (_formKey.currentState!.validate()) {
      print('Recuperar Senha attempt: Email: ${_emailController.text}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Instruções para recuperação enviadas para o seu email (simulado)!')),
      );
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFB74C4C);
    const Color backgroundColor = Color(0xFFFDF3E7);
    const Color cardBackgroundColor = Colors.white;
    const Color textColor = Colors.black87;
    const Color hintColor = Colors.grey;

    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 700; // Adjusted breakpoint

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Use a Column layout for small screens
              if (isSmallScreen) {
                return _buildMobileLayout(
                  context,
                  primaryColor,
                  cardBackgroundColor,
                  textColor,
                  hintColor,
                );
              } else {
                // Use a Row layout for larger screens
                return _buildDesktopLayout(
                  context,
                  primaryColor,
                  cardBackgroundColor,
                  textColor,
                  hintColor,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  // --- Responsive Layout Methods ---

  Widget _buildMobileLayout(
      BuildContext context,
      Color primaryColor,
      Color cardBackgroundColor,
      Color textColor,
      Color hintColor,
      ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLogoSection(primaryColor),
        const SizedBox(height: 40),
        _buildRecoveryFormCard(
          context,
          cardBackgroundColor,
          textColor,
          hintColor,
          primaryColor,
          true, // isMobile
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(
      BuildContext context,
      Color primaryColor,
      Color cardBackgroundColor,
      Color textColor,
      Color hintColor,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left side - Logo
        Expanded(
          flex: 2,
          child: _buildLogoSection(primaryColor),
        ),
        const SizedBox(width: 40), // Spacing between logo and form
        // Right side - Form
        Expanded(
          flex: 3,
          child: _buildRecoveryFormCard(
            context,
            cardBackgroundColor,
            textColor,
            hintColor,
            primaryColor,
            false, // isMobile
          ),
        ),
      ],
    );
  }

  // --- Reusable Widget Sections ---

  Widget _buildLogoSection(Color primaryColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.favorite,
          size: 80,
          color: primaryColor,
        ),
        const SizedBox(height: 10),
         Text(
          'EuMeAmo',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildRecoveryFormCard(
      BuildContext context,
      Color cardBackgroundColor,
      Color textColor,
      Color hintColor,
      Color primaryColor,
      bool isMobile,
      ) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450), // Slightly wider for this form
        child: Card(
          color: cardBackgroundColor,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Recuperar senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                   SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'seuemail@exemplo.com',
                      prefixIcon: Icon(Icons.email_outlined, color: hintColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: hintColor.withOpacity(0.5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: hintColor.withOpacity(0.5)),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.contains('@')) {
                        return 'Por favor, insira um email válido.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _novaSenhaController,
                    decoration: InputDecoration(
                      labelText: 'Nova senha',
                      prefixIcon: Icon(Icons.lock_outline, color: hintColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: hintColor.withOpacity(0.5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: hintColor.withOpacity(0.5)),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'A senha deve ter pelo menos 6 caracteres.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmarNovaSenhaController,
                    decoration: InputDecoration(
                      labelText: 'Confirmar senha',
                      prefixIcon: Icon(Icons.lock_reset_outlined, color: hintColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: hintColor.withOpacity(0.5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: hintColor.withOpacity(0.5)),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, confirme sua nova senha.';
                      }
                      if (value != _novaSenhaController.text) {
                        return 'As senhas não coincidem.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _trocarSenha,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                    child: const Text(
                      'Trocar senha',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

