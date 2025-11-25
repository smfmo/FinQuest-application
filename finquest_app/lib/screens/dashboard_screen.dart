import 'package:flutter/material.dart';
import '../repositories/transacoes_repository.dart';
import '../repositories/metas_repository.dart';
import '../models/transacao.dart';
import '../models/meta.dart';
import 'novo_gasto_screen.dart';
import 'novo_meta_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    _carregarDadosIniciais();
  }

  Future<void> _carregarDadosIniciais() async {
    await Future.wait([
      TransacoesRepository.carregarTransacoes(),
      MetasRepository.carregarMetas(),
    ]);
    setState(() {});
  }

  Future<void> _atualizarDashboard() async {
    await TransacoesRepository.carregarTransacoes();
    setState(() {});
  }

  void _editarSaldo() {
    TextEditingController saldoController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2A2A),
          title: const Text('Definir Saldo Inicial', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: saldoController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Ex: 1500.00',
              hintStyle: TextStyle(color: Colors.grey),
              prefixText: 'R\$ ',
              prefixStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                final valor = double.tryParse(saldoController.text.replaceAll(',', '.')) ?? 0.0;
                TransacoesRepository.definirSaldoInicial(valor);
                setState(() {});
                Navigator.pop(context);
              },
              child: const Text('Salvar', style: TextStyle(color: Colors.amber)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color bgDark = Color(0xFF1A1A1A);
    const Color yellowStart = Color(0xFFFDD835);
    const Color yellowEnd = Color(0xFFFBC02D);
    const Color redAction = Color(0xFFE53935);
    const Color cardBackgroundColor = Color(0xFF2A2A2A);

    final double saldoAtual = TransacoesRepository.saldoTotal;
    final List<Transacao> listaTransacoes = TransacoesRepository.lista;
    final int nivelUser = TransacoesRepository.nivel;
    final double progressoUser = TransacoesRepository.progressoNivel;

    final Meta? metaDestaque = MetasRepository.metaPrioritaria;

    // --- NOVA LÓGICA DE PROGRESSO DA META ---
    double progressoMeta = 0.0;
    if (metaDestaque != null && metaDestaque.valorMeta > 0) {
      // Calcula quanto do saldo cobre a meta
      progressoMeta = saldoAtual / metaDestaque.valorMeta;
      // Garante que fique entre 0% (0.0) e 100% (1.0)
      progressoMeta = progressoMeta.clamp(0.0, 1.0);
    }
    // ----------------------------------------

    String tituloNivel = 'Iniciante';
    if (nivelUser >= 5) tituloNivel = 'Intermediário';
    if (nivelUser >= 10) tituloNivel = 'Avançado';

    return Scaffold(
      backgroundColor: bgDark,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. CABEÇALHO
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
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.account_circle, size: 40, color: Color(0xFF333333)),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Olá, YSAAC RABELO', style: TextStyle(color: Color(0xFF333333), fontSize: 16, fontWeight: FontWeight.bold)),
                              Text('$tituloNivel (Nível $nivelUser)', style: const TextStyle(color: Color(0xFF444444), fontSize: 12)),
                            ],
                          ),
                          const Spacer(),
                          IconButton(icon: const Icon(Icons.settings, color: Color(0xFF333333)), onPressed: () {}),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -30,
                  child: Container(
                    width: 60, height: 60,
                    decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))]),
                    child: const Icon(Icons.arrow_downward, color: yellowEnd, size: 28),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 50),

            // 2. CONTEÚDO PRINCIPAL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  // --- SEÇÃO SALDO ---
                  GestureDetector(
                    onTap: _editarSaldo,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('SALDO ATUAL', yellowStart, textColor: const Color(0xFF333333)),
                            const SizedBox(height: 5),
                            const Text('(Toque para editar)', style: TextStyle(color: Colors.grey, fontSize: 10)),
                          ],
                        ),
                        Text(
                          'R\$ ${saldoAtual.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // --- SEÇÃO GASTOS ---
                  Row(
                    children: [
                      _buildLabel('GASTOS', redAction, textColor: Colors.white),
                      const SizedBox(width: 10),
                      const Text('(Arraste para excluir)', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3F3F3F).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: listaTransacoes.isEmpty
                        ? const Center(child: Text("Nenhum gasto ainda.", style: TextStyle(color: Colors.white54)))
                        : Column(
                      children: listaTransacoes.reversed.take(5).map((transacao) {
                        return Dismissible(
                          key: Key(transacao.id),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) async {
                            await TransacoesRepository.remover(transacao.id);
                            _atualizarDashboard();
                          },
                          background: Container(
                            alignment: Alignment.centerRight,
                            child: const Icon(Icons.delete, color: Colors.red),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFF555555), width: 1))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '-R\$ ${transacao.valor.abs().toStringAsFixed(2).replaceAll('.', ',')}',
                                  style: const TextStyle(color: redAction, fontWeight: FontWeight.w600, fontSize: 16),
                                ),
                                Text(transacao.titulo, style: const TextStyle(color: Color(0xFFCCCCCC), fontSize: 14)),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // --- META INDIVIDUAL (AGORA CONECTADA AO SALDO) ---
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('META PRIORITÁRIA', yellowStart, textColor: const Color(0xFF333333)),
                      const SizedBox(height: 15),

                      if (metaDestaque != null) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(metaDestaque.titulo.toUpperCase(), style: const TextStyle(fontSize: 14, color: Colors.white70, fontWeight: FontWeight.bold)),
                            Text(metaDestaque.prazo, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 5),

                        Text(
                          'R\$ ${metaDestaque.valorMeta.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 8),

                        // Texto de Porcentagem Atualizado com o Saldo
                        Text(
                          'Alcance: ${(progressoMeta * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 14),
                        ),

                        const SizedBox(height: 8),

                        // Barra de Progresso Atualizada com o Saldo
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(color: const Color(0xFF555555), borderRadius: BorderRadius.circular(20)),
                          child: Stack(
                            children: [
                              FractionallySizedBox(
                                widthFactor: progressoMeta, // Usa a variável calculada com o Saldo
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(colors: [yellowStart, yellowEnd]),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                ),
                              ),
                              if (progressoMeta > 0.1)
                                Align(
                                  alignment: Alignment(progressoMeta * 2 - 1.1, 0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(color: yellowStart, borderRadius: BorderRadius.circular(10)),
                                    child: Text(
                                      '${(progressoMeta * 100).toStringAsFixed(0)}%',
                                      style: const TextStyle(color: Color(0xFF333333), fontSize: 9, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        )
                      ] else ...[
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: cardBackgroundColor,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white12),
                          ),
                          child: Column(
                            children: [
                              const Text("Você não tem metas ativas.", style: TextStyle(color: Colors.white54)),
                              const SizedBox(height: 10),
                              TextButton(
                                onPressed: () async {
                                  await Navigator.push(context, MaterialPageRoute(builder: (context) => const NovoMetaScreen()));
                                  _carregarDadosIniciais();
                                },
                                child: Text("CRIAR META AGORA", style: TextStyle(color: yellowStart, fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        )
                      ],
                    ],
                  ),

                  const SizedBox(height: 30),

                  // --- BOTÃO ADICIONAR ---
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: redAction.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 5))],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(context, MaterialPageRoute(builder: (context) => const NovoGastoScreen()));
                        _atualizarDashboard();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: redAction,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        elevation: 0,
                      ),
                      child: const Text('ADICIONAR GASTOS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.0)),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // --- NÍVEL ---
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildLevelText('Iniciante', nivelUser < 5),
                          _buildLevelText('Intermediário', nivelUser >= 5 && nivelUser < 10),
                          _buildLevelText('Avançado', nivelUser >= 10),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        height: 8,
                        width: double.infinity,
                        decoration: BoxDecoration(color: const Color(0xFF555555), borderRadius: BorderRadius.circular(20)),
                        child: FractionallySizedBox(
                          widthFactor: progressoUser > 1.0 ? 1.0 : (progressoUser < 0 ? 0 : progressoUser),
                          alignment: Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [yellowStart, yellowEnd]),
                                borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                        ),
                      ),
                    ],
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

  Widget _buildLabel(String text, Color color, {required Color textColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }

  Widget _buildLevelText(String text, bool isActive) {
    return Text(text, style: TextStyle(color: isActive ? const Color(0xFFFDD835) : const Color(0xFF888888), fontWeight: isActive ? FontWeight.bold : FontWeight.normal, fontSize: 12));
  }
}