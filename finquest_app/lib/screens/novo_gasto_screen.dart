import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Ícones
import 'dart:math'; // Para ID aleatório
import '../models/transacao.dart';
import '../repositories/transacoes_repository.dart';

class NovoGastoScreen extends StatefulWidget {
  const NovoGastoScreen({super.key});

  @override
  State<NovoGastoScreen> createState() => _NovoGastoScreenState();
}

class _NovoGastoScreenState extends State<NovoGastoScreen> {
  // Controladores
  final _valorController = TextEditingController();
  final _tituloController = TextEditingController();
  final _dataController = TextEditingController();
  final _descricaoController = TextEditingController();

  String? _categoriaSelecionada;

  // Categorias
  final List<String> _categorias = ['Alimentação', 'Transporte', 'Lazer', 'Contas', 'Outros'];

  @override
  void dispose() {
    _valorController.dispose();
    _tituloController.dispose();
    _dataController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // --- Cores ---
    const Color bgDark = Color(0xFF121212);
    const Color headerColor = Color(0xFFEEBF00);
    // Usando a cor exata do seu CSS (#3f3f3f) para TODOS os campos
    const Color inputGrey = Color(0xFF3F3F3F);
    const Color textGrey = Color(0xFFCCCCCC);
    const Color buttonRed = Color(0xFFFF0000);

    // Dados do usuário (placeholders)
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
            // 1. CABEÇALHO AMARELO
            // =====================================================
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(25, 60, 25, 50),
                  decoration: const BoxDecoration(
                    color: headerColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF222222),
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
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 4))],
                      ),
                      child: const Icon(FontAwesomeIcons.chevronDown, color: headerColor, size: 18),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // =====================================================
            // 2. CONTEÚDO PRINCIPAL
            // =====================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'NOVO GASTO',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // --- FORM CARD ---

                  // Input Valor
                  _buildInputField(
                    controller: _valorController,
                    hintText: 'Valor (ex: 47.00)',
                    // Não tem ícone no CSS, mas para alinhar o texto, usamos prefixText
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    bgColor: inputGrey,
                    textColor: textGrey,
                    prefixText: 'R\$ ',
                  ),

                  const SizedBox(height: 15),

                  // Input Título
                  _buildInputField(
                    controller: _tituloController,
                    hintText: 'Título (ex: Almoço)',
                    bgColor: inputGrey,
                    textColor: textGrey,
                  ),

                  const SizedBox(height: 15),

                  // Input Data (AGORA PROPORCIONAL)
                  // Usamos o mesmo widget _buildInputField para garantir o tamanho exato
                  _buildInputField(
                    controller: _dataController,
                    hintText: 'Data (Hoje)',
                    icon: FontAwesomeIcons.calendar, // Ícone à esquerda
                    bgColor: inputGrey,
                    textColor: textGrey,
                    isReadOnly: true, // Impede digitar, apenas clica
                    showArrow: true,  // Mostra a seta à direita
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.dark(
                                primary: headerColor,
                                onPrimary: Colors.black,
                                surface: Color(0xFF2A2A2A),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (pickedDate != null) {
                        String formattedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                        setState(() {
                          _dataController.text = formattedDate;
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 15),

                  // Input Categoria (Dropdown)
                  _buildDropdownContainer(
                    color: inputGrey,
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true, // Alinha o texto com os outros inputs
                        child: DropdownButton<String>(
                          value: _categoriaSelecionada,
                          hint: const Text('Categoria', style: TextStyle(color: Color(0xFF888888))),
                          dropdownColor: inputGrey,
                          icon: const Icon(FontAwesomeIcons.chevronDown, color: Colors.white, size: 14),
                          isExpanded: true,
                          style: TextStyle(color: textGrey, fontFamily: 'Poppins', fontSize: 16),
                          items: _categorias.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _categoriaSelecionada = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Input Descrição (TextArea)
                  _buildInputField(
                    controller: _descricaoController,
                    hintText: 'Descrição',
                    bgColor: inputGrey,
                    textColor: textGrey,
                    maxLines: 3,
                  ),

                  const SizedBox(height: 25),

                  // Botão Vermelho
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: buttonRed.withOpacity(0.5),
                          blurRadius: 15,
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      onPressed: _salvarGasto,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonRed,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        elevation: 0,
                      ),
                      child: const Text(
                        'ADICIONAR GASTO',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.0,
                        ),
                      ),
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

  // --- WIDGET UNIFICADO PARA TODOS OS INPUTS ---
  // Isso garante que Data, Valor e Texto tenham a mesma altura e cor
  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required Color bgColor,
    required Color textColor,
    IconData? icon,
    bool isReadOnly = false,
    VoidCallback? onTap,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? prefixText,
    bool showArrow = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        readOnly: isReadOnly,
        onTap: onTap,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xFF888888)),
          border: InputBorder.none,
          prefixText: prefixText,
          prefixStyle: TextStyle(color: textColor),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          // Ícone da esquerda (Opcional)
          prefixIcon: icon != null
              ? Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Icon(icon, color: const Color(0xFF888888), size: 18),
          )
              : null,
          prefixIconConstraints: const BoxConstraints(minWidth: 40, maxHeight: 24),
          // Seta da direita (para Data)
          suffixIcon: showArrow
              ? const Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(FontAwesomeIcons.chevronDown, color: Colors.white, size: 14),
          )
              : null,
          suffixIconConstraints: const BoxConstraints(minWidth: 40, maxHeight: 24),
        ),
      ),
    );
  }

  // Widget específico para o Dropdown (mas com o mesmo estilo de container)
  Widget _buildDropdownContainer({required Widget child, required Color color}) {
    return Container(
      width: double.infinity,
      //padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  void _salvarGasto() {
    if (_valorController.text.isEmpty || _tituloController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha valor e título!')),
      );
      return;
    }

    final valorDouble = double.tryParse(_valorController.text.replaceAll(',', '.')) ?? 0.0;

    final novaTransacao = Transacao(
      id: Random().nextDouble().toString(),
      titulo: _tituloController.text,
      valor: valorDouble,
      data: _dataController.text.isEmpty ? DateTime.now() : DateTime.now(),
      categoria: _categoriaSelecionada ?? 'Outros',
      descricao: _descricaoController.text,
    );

    TransacoesRepository.adicionar(novaTransacao);
    Navigator.pop(context);
  }
}