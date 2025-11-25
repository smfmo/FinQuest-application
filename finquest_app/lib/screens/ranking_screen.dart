import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Ícones
import '../repositories/transacoes_repository.dart'; // Dados do usuário

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // --- Cores do seu CSS ---
    const Color bgDark = Color(0xFF1A1A1A);
    const Color cardDark = Color(0xFF2A2A2A);
    const Color yellowStart = Color(0xFFFDD835);
    const Color yellowEnd = Color(0xFFE6B000);
    const Color textGrey = Color(0xFFAAAAAA);

    // Dados do Usuário
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
            // 1. CABEÇALHO AMARELO (Igual Dicas e Dashboard)
            // =====================================================
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(25, 60, 25, 50),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [yellowStart, yellowEnd],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Top Bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
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
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  Text(
                                    tituloNivel,
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Icon(FontAwesomeIcons.gear, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
                // Notch
                Positioned(
                  bottom: -20,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 4))],
                    ),
                    child: const Icon(FontAwesomeIcons.chevronDown, color: yellowEnd, size: 20),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // =====================================================
            // 2. CONTEÚDO PRINCIPAL (Título e Tabela)
            // =====================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  // Título da Página
                  const Text(
                    'Ranking',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(color: Colors.black45, offset: Offset(0, 2), blurRadius: 4)],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --- CARD DE RANKING (Tabela) ---
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: cardDark,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF333333)),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20, offset: const Offset(0, 4))],
                    ),
                    child: Column(
                      children: [
                        // Cabeçalho da Tabela
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            children: const [
                              SizedBox(width: 35, child: Text('', style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(child: Text('Username', style: TextStyle(color: textGrey, fontSize: 14))),
                              SizedBox(width: 70, child: Center(child: Text('Nível', style: TextStyle(color: textGrey, fontSize: 14)))),
                              SizedBox(width: 60, child: Align(alignment: Alignment.centerRight, child: Text('Score', style: TextStyle(color: textGrey, fontSize: 14)))),
                            ],
                          ),
                        ),

                        // Linhas da Tabela
                        _buildRankingRow('1', 'Maria123', 3, 9450, false, yellowStart),
                        _buildRankingRow('2', 'JoaoSilva', 3, 8420, false, yellowStart),
                        _buildRankingRow('3', 'Eduardo', 2, 7405, false, yellowStart),
                        _buildRankingRow('4', 'Fernanda', 2, 6730, false, yellowStart),

                        // Usuário Destacado (Ysaac)
                        _buildRankingRow('5', 'Ysaac', 2, 5395, true, yellowStart),

                        _buildRankingRow('6', 'Samuel', 2, 5060, false, yellowStart),
                        _buildRankingRow('7', 'Vini', 1, 4450, false, yellowStart),
                        _buildRankingRow('8', 'Felipe', 1, 4360, false, yellowStart),
                        _buildRankingRow('9', 'Carlos', 1, 3405, false, yellowStart),
                        _buildRankingRow('10', 'André', 1, 3230, false, yellowStart),
                        _buildRankingRow('11', 'Paulo', 1, 2395, false, yellowStart),
                        _buildRankingRow('12', 'Jhon', 1, 2060, false, yellowStart),
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

  // Widget auxiliar para construir cada linha
  Widget _buildRankingRow(String rank, String username, int nivel, int score, bool isUser, Color starColor) {
    // Cria as estrelas
    List<Widget> stars = List.generate(
      nivel,
          (index) => Icon(Icons.star, color: isUser ? Colors.white : starColor, size: 12),
    );

    return Container(
      margin: isUser ? const EdgeInsets.symmetric(vertical: 5) : const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: isUser ? BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFBC02D), Color(0xFFFDD835)]),
        boxShadow: [BoxShadow(color: const Color(0xFFFDD835).withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 2))],
      ) : null,
      child: Row(
        children: [
          // Coluna Rank
          SizedBox(
            width: 35,
            child: Text(
              rank,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Coluna Username
          Expanded(
            child: Text(
              username,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.white,
                fontWeight: isUser ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          // Coluna Nível (Estrelas)
          SizedBox(
            width: 70,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: stars,
              ),
            ),
          ),
          // Coluna Score
          SizedBox(
            width: 60,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                score.toString(),
                style: TextStyle(
                  color: isUser ? Colors.white : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}