import 'package:flutter/material.dart';
import 'dart:math';
import '../models/meta.dart';
import '../repositories/metas_repository.dart';

class NovoMetaScreen extends StatefulWidget {
  const NovoMetaScreen({super.key});

  @override
  State<NovoMetaScreen> createState() => _NovoMetaScreenState();
}

class _NovoMetaScreenState extends State<NovoMetaScreen> {
  final _tituloController = TextEditingController();
  final _valorMetaController = TextEditingController();
  final _prazoController = TextEditingController();

  @override
  void dispose() {
    _tituloController.dispose();
    _valorMetaController.dispose();
    _prazoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color amareloFinQuest = Colors.amber[700]!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('NOVA META', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_downward_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            // Título da Meta
            TextFormField(
              controller: _tituloController,
              decoration: const InputDecoration(
                hintText: 'Título (ex: Viagem, Carro)',
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: Icon(Icons.flag, color: Colors.white54),
              ),
            ),

            const SizedBox(height: 20),

            // Valor do Objetivo
            TextFormField(
              controller: _valorMetaController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                hintText: 'Valor do Objetivo (ex: 5000.00)',
                hintStyle: TextStyle(color: Colors.white54),
                prefixText: 'R\$ ',
                prefixStyle: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),

            // Prazo
            TextFormField(
              controller: _prazoController,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now().add(const Duration(days: 30)),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  String formattedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                  setState(() {
                    _prazoController.text = formattedDate;
                  });
                }
              },
              decoration: const InputDecoration(
                hintText: 'Prazo (Data limite)',
                hintStyle: TextStyle(color: Colors.white54),
                suffixIcon: Icon(Icons.calendar_today, color: Colors.white54),
              ),
            ),

            const SizedBox(height: 40),

            // Botão Salvar
            ElevatedButton(
              onPressed: () {
                if (_tituloController.text.isEmpty || _valorMetaController.text.isEmpty) {
                  return;
                }

                final valorMeta = double.tryParse(_valorMetaController.text.replaceAll(',', '.')) ?? 0.0;

                // Cria a nova meta
                final novaMeta = Meta(
                  id: Random().nextDouble().toString(),
                  titulo: _tituloController.text,
                  valorAtual: 0.0, // Começa com zero guardado
                  valorMeta: valorMeta,
                  prazo: _prazoController.text.isEmpty ? 'Sem prazo' : _prazoController.text,
                );

                // Salva no banco
                MetasRepository.adicionar(novaMeta);

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: amareloFinQuest,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('CRIAR META', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}