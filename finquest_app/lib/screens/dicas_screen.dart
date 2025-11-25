import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Ícones
import '../repositories/transacoes_repository.dart'; // Para pegar nome/nível

class DicasScreen extends StatefulWidget {
  const DicasScreen({super.key});

  @override
  State<DicasScreen> createState() => _DicasScreenState();
}

class _DicasScreenState extends State<DicasScreen> {
  // Índice da dica selecionada. Começamos com 3 (Dívidas) para igualar seu design
  int _selectedIndex = 3;

  // Dados das Dicas
  final List<Map<String, dynamic>> _dicas = [
    {
      'titulo': 'Orçamento',
      'icon': FontAwesomeIcons.coins,
      'texto': 'O orçamento é a base de tudo. Anote todos os seus ganhos e gastos. Defina limites para categorias como lazer e alimentação e tente segui-los rigorosamente.'
    },
    {
      'titulo': 'Investimento',
      'icon': FontAwesomeIcons.chartLine,
      'texto': 'Comece cedo, mesmo com pouco. O segredo dos juros compostos é o tempo. Estude sobre Renda Fixa e Tesouro Direto para começar com segurança.'
    },
    {
      'titulo': 'Economia',
      'icon': FontAwesomeIcons.piggyBank,
      'texto': 'Economizar não é deixar de viver, é gastar com inteligência. Pesquise preços, evite compras por impulso e pergunte-se: "Eu preciso disso agora?".'
    },
    {
      'titulo': 'Dívidas',
      'icon': FontAwesomeIcons.sackDollar,
      'texto': 'Sempre que possível, planeje suas compras e evite gastar por impulso. Dívidas com juros altos, como as de cartão de crédito ou cheque especial, podem se tornar uma bola de neve. Priorize o pagamento das dívidas mais caras primeiro.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    // --- Cores do seu CSS ---
    const Color bgDark = Color(0xFF1A1A1A);
    const Color headerStart = Color(0xFFFDD835); // Amarelo claro
    const Color headerEnd = Color(0xFFE6B000);   // Amarelo escuro
    const Color cardGrey = Color(0xFF333333);    // Fundo dos botões

    // Dados do Usuário (Vindos do Repositório)
    final int nivelUser = TransacoesRepository.nivel;
    String tituloNivel = 'Iniciante';
    if (nivelUser >= 5) tituloNivel = 'Intermediário';
    if (nivelUser >= 10) tituloNivel = 'Avançado';

    return Scaffold(
      backgroundColor: bgDark,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // =====================================================
            // 1. CABEÇALHO AMARELO (Igual ao CSS .header)
            // =====================================================
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(25, 60, 25, 60),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [headerStart, headerEnd],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Top Bar (Perfil e Config)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              // Avatar Circle
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF333333),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: const Icon(FontAwesomeIcons.user, color: Colors.white, size: 20),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'YSAAC RABELO',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    tituloNivel,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Icon(FontAwesomeIcons.gear, color: Colors.white),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Título da Página
                      const Text(
                        'Dicas',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // O "Entalhe" (Notch Branco)
                Positioned(
                  bottom: -25,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: const Icon(FontAwesomeIcons.chevronDown, color: headerEnd, size: 20),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 50), // Espaço após o header

            // =====================================================
            // 2. CONTEÚDO PRINCIPAL (.content-area)
            // =====================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [

                  // --- LISTA DE MENUS (Botões Cinzas) ---
                  // Mostra todos, exceto o que está selecionado (que vira o card grande)
                  ..._dicas.asMap().entries.map((entry) {
                    int idx = entry.key;
                    Map<String, dynamic> dica = entry.value;

                    if (idx == _selectedIndex) return const SizedBox.shrink(); // Não mostra na lista se estiver ativo

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedIndex = idx;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: cardGrey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              // Box do Ícone
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF444444),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color(0xFF555555)),
                                ),
                                child: Icon(dica['icon'], color: Colors.white, size: 22),
                              ),
                              const SizedBox(width: 20),
                              Text(
                                dica['titulo'],
                                style: const TextStyle(
                                  color: Color(0xFFEEEEEE),
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 20),

                  // --- CARD ATIVO (Amarelo - .active-card) ---
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF2A2A2A), // Fundo interno
                    ),
                    clipBehavior: Clip.hardEdge, // Para cortar o header
                    child: Column(
                      children: [
                        // Header do Card
                        Container(
                          color: const Color(0xFFFBC02D), // Amarelo do header
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: Icon(_dicas[_selectedIndex]['icon'], color: Colors.white, size: 20),
                              ),
                              const SizedBox(width: 20),
                              Text(
                                _dicas[_selectedIndex]['titulo'].toString().toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Corpo do Card (Texto)
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              // Simulando borda tracejada com borda sólida amarela
                              border: Border.all(color: const Color(0xFFFBC02D), width: 1, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  _dicas[_selectedIndex]['texto'],
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    color: Color(0xFFDDDDDD),
                                    fontSize: 14,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'Ler mais...',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}