import 'package:flutter/material.dart';
import '../models/meta.dart';
import '../repositories/metas_repository.dart';
import 'novo_meta_screen.dart';

class MetasScreen extends StatefulWidget {
  const MetasScreen({super.key});

  @override
  State<MetasScreen> createState() => _MetasScreenState();
}

class _MetasScreenState extends State<MetasScreen> {

  @override
  void initState() {
    super.initState();
    _carregarMetas();
  }

  Future<void> _carregarMetas() async {
    await MetasRepository.carregarMetas();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Color amareloFinQuest = Colors.amber[700]!;
    final List<Meta> listaMetas = MetasRepository.lista;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'METAS',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Lista de Metas
          listaMetas.isEmpty
              ? const Center(child: Text('Nenhuma meta criada.', style: TextStyle(color: Colors.white54)))
              : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 100.0),
              itemCount: listaMetas.length,
              itemBuilder: (context, index) {
                final meta = listaMetas[index];
                return Dismissible(
                  key: Key(meta.id),
                  background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), child: const Icon(Icons.delete, color: Colors.white)),
                  onDismissed: (direction) async {
                    await MetasRepository.remover(meta.id);
                    setState(() {});
                  },
                  child: _buildMetaItem(
                    icone: Icons.flag, // Ícone padrão
                    titulo: meta.titulo,
                    prazo: 'Prazo: ${meta.prazo}',
                    // Calcula porcentagem
                    status: 'Progresso: ${(meta.progresso * 100).toStringAsFixed(0)}%',
                    valorTexto: 'R\$ ${meta.valorAtual} / ${meta.valorMeta}',
                    statusCor: Colors.white70,
                    concluida: meta.concluida == 1,
                  ),
                );
              },
            ),
          ),

          // Botão "ADICIONAR META"
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NovoMetaScreen()),
                  );
                  _carregarMetas(); // Atualiza ao voltar
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: amareloFinQuest,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'ADICIONAR META',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaItem({
    required IconData icone,
    required String titulo,
    required String prazo,
    required String status,
    required String valorTexto,
    required Color statusCor,
    required bool concluida,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[850]!.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(icone, color: Colors.white, size: 28),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(titulo, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(prazo, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                      Text(valorTexto, style: const TextStyle(color: Colors.amber, fontSize: 12)), // Mostra valor
                      const SizedBox(height: 4),
                      Text(status, style: TextStyle(color: statusCor, fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: concluida ? Colors.amber[700]! : Colors.grey[600]!, width: 2),
              color: concluida ? Colors.amber[700]! : Colors.transparent,
            ),
            child: concluida ? const Icon(Icons.check, color: Colors.black, size: 16) : null,
          ),
        ],
      ),
    );
  }
}