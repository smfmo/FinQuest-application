import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../repositories/transacoes_repository.dart';
import '../models/transacao.dart';

class ExtratoScreen extends StatefulWidget {
  const ExtratoScreen({super.key});

  @override
  State<ExtratoScreen> createState() => _ExtratoScreenState();
}

class _ExtratoScreenState extends State<ExtratoScreen> {

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    await TransacoesRepository.carregarTransacoes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const Color bgDark = Color(0xFF121212);
    const Color headerColor = Color(0xFFEEBF00);
    const Color cardGrey = Color(0xFF38383A);
    const Color textRed = Color(0xFFFF3B30);

    final int nivelUser = TransacoesRepository.nivel;
    String tituloNivel = 'Iniciante';
    if (nivelUser >= 5) tituloNivel = 'Intermediário';
    if (nivelUser >= 10) tituloNivel = 'Avançado';

    final List<Transacao> listaReal = TransacoesRepository.lista;

    return Scaffold(
      backgroundColor: bgDark,
      body: Column(
        children: [
          // --- CABEÇALHO ---
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(25, 60, 25, 50),
                decoration: const BoxDecoration(
                  color: headerColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 45, height: 45,
                              decoration: BoxDecoration(color: const Color(0xFF1C1C1E), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                              child: const Icon(FontAwesomeIcons.user, color: Colors.white, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('YSAAC RABELO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                                Text(tituloNivel, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 12)),
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
              Positioned(
                bottom: -22,
                child: Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 4))]),
                  child: const Icon(FontAwesomeIcons.chevronDown, color: headerColor, size: 18),
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // --- CONTEÚDO PRINCIPAL ---
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const Text('EXTRATO', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                  const SizedBox(height: 25),

                  Row(
                    children: [
                      Expanded(child: _buildFilterButton('Categoria', true, headerColor)),
                      const SizedBox(width: 15),
                      Expanded(child: _buildFilterButton('Período', false, const Color(0xFF38383A))),
                    ],
                  ),

                  const SizedBox(height: 10),
                  const Align(alignment: Alignment.centerRight, child: Text('Transações Recentes', style: TextStyle(color: Color(0xFF888888), fontSize: 11))),
                  const SizedBox(height: 15),

                  Expanded(
                    child: listaReal.isEmpty
                        ? const Center(child: Text('Nenhuma transação ainda.', style: TextStyle(color: Colors.white54)))
                        : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: listaReal.length,
                      itemBuilder: (context, index) {
                        final transacao = listaReal[listaReal.length - 1 - index];

                        // Visual Padronizado de Gasto
                        String valorFormatado = '-R\$ ${transacao.valor.abs().toStringAsFixed(2).replaceAll('.', ',')}';

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(color: cardGrey, borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(valorFormatado, style: TextStyle(color: textRed, fontWeight: FontWeight.bold, fontSize: 15)),
                                      const SizedBox(width: 8),
                                      Text(transacao.titulo, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 14)),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(transacao.categoria, style: const TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w300, fontSize: 12)),
                                ],
                              ),
                              const Icon(FontAwesomeIcons.cartShopping, color: Colors.white54, size: 18),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text, bool isActive, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: TextStyle(color: isActive ? Colors.black : const Color(0xFFCCCCCC), fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(width: 10),
          Icon(FontAwesomeIcons.chevronDown, size: 12, color: isActive ? Colors.black : const Color(0xFFCCCCCC)),
        ],
      ),
    );
  }
}