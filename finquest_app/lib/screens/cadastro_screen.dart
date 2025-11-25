import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Ícones Google/Facebook
import 'home_screen.dart'; // Para ir ao Dashboard
import 'login_screen.dart'; // Para ir ao Login

class CadastroScreen extends StatelessWidget {
  const CadastroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // --- Cores do seu CSS ---
    const Color yellowMain = Color(0xFFFDD835); // Amarelo principal

    // Gradiente de fundo
    const BoxDecoration backgroundDecoration = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF333333),
          Color(0xFF1A1A1A),
        ],
      ),
    );

    return Scaffold(
      body: Container(
        decoration: backgroundDecoration, // Aplica o fundo gradiente
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // --- Ícone do Topo (Porquinho) ---
                  const Icon(
                    FontAwesomeIcons.piggyBank,
                    size: 50,
                    color: yellowMain,
                  ),

                  const SizedBox(height: 30),

                  // --- Container Principal do Formulário (Vidro/Glass) ---
                  Container(
                    padding: const EdgeInsets.all(40.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Título CADASTRO
                        const Text(
                          'CADASTRO',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.0,
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Campo Username
                        _buildInputField(hintText: 'username', icon: Icons.person_outline),

                        const SizedBox(height: 20),

                        // Campo Email
                        _buildInputField(hintText: 'email', icon: Icons.email_outlined, keyboardType: TextInputType.emailAddress),

                        const SizedBox(height: 20),

                        // Campo Senha
                        _buildInputField(hintText: 'senha', icon: Icons.lock_outline, isPassword: true),

                        const SizedBox(height: 30),

                        // --- Botões Sociais ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildSocialButton(
                              icon: FontAwesomeIcons.google,
                              color: const Color(0xFFDB4437), // Vermelho Google
                              bgColor: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.0),
                              child: Text('ou', style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 14)),
                            ),
                            _buildSocialButton(
                              icon: FontAwesomeIcons.facebookF,
                              color: Colors.white,
                              bgColor: const Color(0xFF1877F2), // Azul Facebook
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // Botão FINALIZAR (Vai para a Home)
                        ElevatedButton(
                          onPressed: () {
                            // Navega para a HomeScreen (Dashboard)
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: yellowMain,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            shadowColor: const Color(0xFFC8A000),
                            elevation: 4,
                          ),
                          child: const Text(
                            'FINALIZAR',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Link "Já tenho cadastro!" (Vai para o Login)
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      'Já tenho cadastro!',
                      style: TextStyle(
                        color: yellowMain,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Logo do Rodapé
                  const Text(
                    'FINQUEST',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const Text(
                    'Plataforma de finanças Gamificada',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFAAAAAA),
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

  // Widget auxiliar para Inputs
  Widget _buildInputField({
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF3F3F3F),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextField(
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xFFAAAAAA), fontWeight: FontWeight.normal),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Icon(icon, color: const Color(0xFFAAAAAA), size: 20),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  // Widget auxiliar para Botões Sociais
  Widget _buildSocialButton({required IconData icon, required Color color, required Color bgColor}) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: color, size: 24),
        onPressed: () {},
      ),
    );
  }
}