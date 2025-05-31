// Views/auth/cadastro_especialista_screen.dart
import 'package:flutter/material.dart';

class CadastroEspecialistaScreen extends StatefulWidget {
  const CadastroEspecialistaScreen({super.key});

  @override
  State<CadastroEspecialistaScreen> createState() =>
      _CadastroEspecialistaScreenState();
}

class _CadastroEspecialistaScreenState
    extends State<CadastroEspecialistaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _crmController = TextEditingController();

  String? _selectedArea;
  final List<String> _areasProfissionais = [
    'Nutricionista',
    'Personal Trainer',
    'Fisioterapeuta',
    'Psicólogo',
    'Educador Físico',
  ];

  // Placeholder for selected file name
  String? _curriculoFileName;

  void _submitApplication() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;
      String area = _selectedArea ?? '';
      String crm = _crmController.text;
      print(
          'Application submitted: Name: $name, Email: $email, Area: $area, CRM/ID: $crm, File: $_curriculoFileName');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Solicitação enviada com sucesso! Aguarde a aprovação.')),
      );
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  // Mock file picker function
  void _pickFile() {
    // In a real app, use file_picker package
    setState(() {
      _curriculoFileName = 'curriculo_selecionado.pdf'; // Mock file name
    });
    print('File picker opened (simulated)');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _crmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFB74C4C);
    const Color backgroundColor = Color(0xFFFDF3E7);
    const Color cardBackgroundColor = Colors.white;
    const Color textColor = Color(0xFF4D342F);
    const Color hintColor = Colors.grey;

    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: isSmallScreen ? AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ) : null,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (isSmallScreen) {
                return _buildMobileLayout(
                  context,
                  primaryColor,
                  cardBackgroundColor,
                  textColor,
                  hintColor,
                );
              } else {
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
        _buildLogoSection(primaryColor, textColor, true),
        const SizedBox(height: 40),
        _buildSpecialistFormCard(
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
        Expanded(
          flex: 1,
          child: _buildLogoSection(primaryColor, textColor, false),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 1,
          child: _buildSpecialistFormCard(
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

  Widget _buildLogoSection(Color primaryColor, Color textColor, bool isMobile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.favorite,
          size: isMobile ? 60 : 80,
          color: primaryColor,
        ),
        const SizedBox(height: 10),
        Text(
          'EuMeAmo',
          style: TextStyle(
            fontSize: isMobile ? 36 : 48,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Faça parte da nossa equipe de especialistas!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: textColor.withOpacity(0.8),
          ),
        )
      ],
    );
  }

  Widget _buildSpecialistFormCard(
      BuildContext context,
      Color cardBackgroundColor,
      Color textColor,
      Color hintColor,
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
                    'Venha fazer parte do EuMeAmo!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 20 : 22,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      hintText: 'Seu nome completo',
                      prefixIcon: Icon(Icons.person_outline, color: hintColor),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu nome';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Seu email profissional',
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
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
                        return 'Por favor, insira um email válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedArea,
                    decoration: InputDecoration(
                      labelText: 'Área profissional',
                      prefixIcon: Icon(Icons.work_outline, color: hintColor),
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
                    items: _areasProfissionais.map((String area) {
                      return DropdownMenuItem<String>(
                        value: area,
                        child: Text(area),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedArea = newValue;
                      });
                    },
                    validator: (value) =>
                    value == null ? 'Selecione sua área' : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _crmController,
                    decoration: InputDecoration(
                      labelText: 'Identificador Profissional',
                      hintText: 'CRM, CREF, CRP, etc.',
                      prefixIcon: Icon(Icons.badge_outlined, color: hintColor),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu identificador';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Curriculum Upload Field
                  InkWell(
                    onTap: _pickFile,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Currículo (PDF)',
                        prefixIcon: Icon(Icons.attach_file_outlined, color: hintColor),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              _curriculoFileName ?? 'Anexar arquivo',
                              style: TextStyle(
                                color: _curriculoFileName != null ? textColor : hintColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(Icons.upload_file, color: primaryColor),
                        ],
                      ),
                    ),
                  ),
                  // Add validator message display if needed
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _submitApplication,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Enviar solicitação',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      },
                      child: Text(
                        'Voltar para Login',
                        style: TextStyle(
                            color: textColor, decoration: TextDecoration.underline),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

