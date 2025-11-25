import 'package:flutter/material.dart';
import 'screens/cadastro_screen.dart'; // Importa a tela que vamos criar

void main() {
  runApp(const FinQuestApp());
}

class FinQuestApp extends StatelessWidget {
  const FinQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinQuest',
      // Define o tema escuro como padrão para o app
      theme: ThemeData.dark().copyWith(
        // Define a cor de fundo padrão para o preto do seu design
        scaffoldBackgroundColor: const Color(0xFF121212),
        // Define a cor de destaque principal (o amarelo/dourado)
        primaryColor: const Color(0xFFFFD180), // Um tom de dourado
        // Estilo dos campos de texto para combinar com o design
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[850], // Cor de fundo do campo de texto
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none, // Sem borda
          ),
        ),
      ),
      home: const CadastroScreen(), // A primeira tela a ser mostrada
      debugShowCheckedModeBanner: false, // Remove a faixa de "Debug"
    );
  }
}