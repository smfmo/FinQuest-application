import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'extrato_screen.dart';
import 'metas_screen.dart';
import 'ranking_screen.dart';
import 'dicas_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Guarda o índice (a posição) da tela que está selecionada
  int _selectedIndex = 0;

  // Lista de todas as telas que a barra de navegação vai controlar
  static const List<Widget> _telas = <Widget>[
    DashboardScreen(),
    ExtratoScreen(),
    MetasScreen(),
    RankingScreen(),
    DicasScreen(),
  ];

  // Função que é chamada quando o usuário toca em um ícone da barra
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Atualiza o índice para a nova tela
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // O corpo da tela agora é a tela que está selecionada na nossa lista
      body: _telas.elementAt(_selectedIndex),

      // A Barra de Navegação Inferior
      bottomNavigationBar: BottomNavigationBar(
        // --- Estilização para combinar com seu design ---
        type: BottomNavigationBarType.fixed, // Garante que todos os 5 ícones apareçam
        backgroundColor: const Color(0xFF121212), // Cor de fundo preta
        selectedItemColor: Colors.amber[700], // Cor do ícone selecionado
        unselectedItemColor: Colors.grey[600], // Cor dos ícones não selecionados
        showUnselectedLabels: false, // Esconde o texto dos ícones não selecionados

        // --- Itens da Barra ---
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Extrato',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Metas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Ranking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            label: 'Dicas',
          ),
        ],
        currentIndex: _selectedIndex, // Diz qual ícone está ativo
        onTap: _onItemTapped, // O que fazer quando um ícone é tocado
      ),
    );
  }
}