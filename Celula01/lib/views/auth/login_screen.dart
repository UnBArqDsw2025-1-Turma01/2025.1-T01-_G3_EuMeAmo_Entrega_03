// Views/auth/login_screen.dart
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      print('Login attempt: Email: $email');
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFB74C4C);
    const Color backgroundColor = Color(0xFFFDF3E7);
    const Color cardBackgroundColor = Colors.white;
    const Color textColor = Color(0xFF4D342F);
    const Color hintColor = Colors.grey;
    const Color linkColor = Color(0xFF8DC63F);

    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    return Scaffold(
      backgroundColor: backgroundColor,
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
                  linkColor,
                );
              } else {
                // Use a Row layout for larger screens
                return _buildDesktopLayout(
                  context,
                  primaryColor,
                  cardBackgroundColor,
                  textColor,
                  hintColor,
                  linkColor,
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
      Color linkColor,
      ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLogoSection(primaryColor, textColor),
        const SizedBox(height: 40),
        _buildLoginFormCard(
          context,
          cardBackgroundColor,
          textColor,
          hintColor,
          linkColor,
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
      Color linkColor,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left side - Logo
        Expanded(
          flex: 1,
          child: _buildLogoSection(primaryColor, textColor),
        ),
        const SizedBox(width: 40), // Spacing between logo and form
        // Right side - Login Form
        Expanded(
          flex: 1,
          child: _buildLoginFormCard(
            context,
            cardBackgroundColor,
            textColor,
            hintColor,
            linkColor,
            primaryColor,
            false, // isMobile
          ),
        ),
      ],
    );
  }

  // --- Reusable Widget Sections ---

  Widget _buildLogoSection(Color primaryColor, Color textColor) {
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
        Text(
          'Cuide de você, ame-se mais.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: textColor.withOpacity(0.8),
          ),
        )
      ],
    );
  }

  Widget _buildLoginFormCard(
      BuildContext context,
      Color cardBackgroundColor,
      Color textColor,
      Color hintColor,
      Color linkColor,
      Color primaryColor,
      bool isMobile,
      ) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
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
                children: [
                  Text(
                    'Faça login no EuMeAmo!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                   SizedBox(height: 30),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'seuemail@exemplo.com',
                      prefixIcon: Icon(Icons.email_outlined, color: hintColor),
                      border: OutlineInputBorder( // Added border for consistency
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
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Por favor, insira um email válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      hintText: '********',
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
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira sua senha';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        )
                    ),
                    child: const Text('Fazer Login', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                  const SizedBox(height: 20),
                  // Use Wrap for links on smaller screens
                  Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 8.0, // Space between lines if wrapped
                    spacing: 4.0, // Space between text and link
                    children: [
                      Text('Não tem uma conta?', style: TextStyle(color: textColor)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/cadastro_aluno');
                        },
                        child: Text(
                          'Cadastre-se aqui.',
                          style: TextStyle(color: linkColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 8.0,
                    spacing: 4.0,
                    children: [
                      Text('Esqueceu a senha?', style: TextStyle(color: textColor)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/recuperar_senha');
                        },
                        child: Text(
                          'Recupere aqui.',
                          style: TextStyle(color: linkColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
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

