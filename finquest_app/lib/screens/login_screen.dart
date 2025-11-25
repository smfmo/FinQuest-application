import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Importa ícones extras
import 'home_screen.dart';
import 'cadastro_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // --- Cores do seu CSS ---
    const Color bgDark = Color(0xFF1A1A1A); // #1a1a1a
    const Color yellowMain = Color(0xFFFDD835); // #fdd835 (Amarelo principal)
    const Color yellowDark = Color(0xFFFBC02D); // #fbc02d (Amarelo escuro/hover)

    // Gradiente de fundo (do seu CSS body)
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
                    size: 50, // 2.5rem
                    color: yellowMain,
                  ),

                  const SizedBox(height: 30),

                  // --- Container Principal do Formulário ---
                  Container(
                    padding: const EdgeInsets.all(40.0), // 40px 30px
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A).withOpacity(0.9), // rgba(42, 42, 42, 0.9)
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
                        // Título LOGIN
                        const Text(
                          'LOGIN',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28, // 1.8rem
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.0,
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Campo E-mail
                        _buildInputField(hintText: 'email', icon: Icons.email_outlined),

                        const SizedBox(height: 20),

                        // Campo Senha
                        _buildInputField(hintText: 'senha', icon: Icons.lock_outline, isPassword: true),

                        const SizedBox(height: 30),

                        // --- Login Social ---
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

                        // Botão ENTRAR
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeScreen()),
                                  (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: yellowMain,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50), // Bordas redondas
                            ),
                            shadowColor: const Color(0xFFC8A000), // Sombra amarela escura
                            elevation: 4,
                          ),
                          child: const Text(
                            'ENTRAR',
                            style: TextStyle(
                              fontSize: 18, // 1.1rem
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Link "Já tenho cadastro!"
                  TextButton(
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const CadastroScreen()),
                        );
                      }
                    },
                    child: Text(
                      'Cadastre-se',
                      style: TextStyle(
                        color: yellowMain,
                        fontSize: 14, // 0.9rem
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none, // No Flutter usamos TextButton, sem sublinhado padrão
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Logo do Rodapé
                  const Text(
                    'FINQUEST',
                    style: TextStyle(
                      fontSize: 28, // 1.8rem
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const Text(
                    'Plataforma de finanças Gamificada',
                    style: TextStyle(
                      fontSize: 12, // 0.8rem
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

  // Widget auxiliar para os campos de texto (Input Group)
  Widget _buildInputField({required String hintText, required IconData icon, bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF3F3F3F),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextField(
        obscureText: isPassword,
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

  // Widget auxiliar para os botões sociais
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