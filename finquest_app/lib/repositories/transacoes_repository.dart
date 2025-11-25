import 'package:flutter/material.dart';
import '../models/transacao.dart';
import '../helpers/database_helper.dart'; // Voltamos a usar o Helper do SQLite

class TransacoesRepository {
  // Cache local da lista
  static List<Transacao> _listaTransacoes = [];

  // Variável para o dinheiro que o usuário tem (Saldo Inicial)
  static double _saldoInicial = 0.0;

  // Variáveis de Gamificação
  static int _nivel = 1;
  static double _xpAtual = 0.0;
  static double _xpParaProximoNivel = 100.0;

  // Getters para ler os dados
  static List<Transacao> get lista => List.unmodifiable(_listaTransacoes);
  static int get nivel => _nivel;
  static double get xpAtual => _xpAtual;
  static double get xpParaProximoNivel => _xpParaProximoNivel;
  static double get progressoNivel => _xpAtual / _xpParaProximoNivel;

  // --- LÓGICA DE SALDO ---
  // (Dinheiro que você tem) - (Soma dos gastos)
  static double get saldoTotal {
    double totalGastos = 0.0;
    for (var t in _listaTransacoes) {
      // .abs() garante que somamos o tamanho do gasto positivo
      totalGastos += t.valor.abs();
    }
    return _saldoInicial - totalGastos;
  }

  // Função para definir o saldo inicial
  static void definirSaldoInicial(double valor) {
    _saldoInicial = valor;
  }

  // --- CARREGAR (DO SQLite) ---
  static Future<void> carregarTransacoes() async {
    // Busca os dados do banco local no celular
    final transacoesDoBanco = await DatabaseHelper().getTransacoes();
    _listaTransacoes = transacoesDoBanco;
  }

  // --- ADICIONAR (NO SQLite) ---
  static Future<void> adicionar(Transacao transacao) async {
    // 1. Salva no arquivo .db do celular
    await DatabaseHelper().insertTransacao(transacao);

    // 2. Adiciona na lista da memória para atualizar a tela na hora
    _listaTransacoes.add(transacao);

    // Lógica de Gamificação
    double xpGanho = 10.0 + (transacao.valor.abs() * 0.1);
    _adicionarXp(xpGanho);
  }

  // --- REMOVER (NO SQLite) ---
  static Future<void> remover(String id) async {
    // 1. Remove do arquivo .db
    await DatabaseHelper().deleteTransacao(id);

    // 2. Remove da lista da memória
    _listaTransacoes.removeWhere((t) => t.id == id);
  }

  // Lógica de subir de nível
  static void _adicionarXp(double valor) {
    _xpAtual += valor;
    if (_xpAtual >= _xpParaProximoNivel) {
      _xpAtual -= _xpParaProximoNivel;
      _nivel++;
      _xpParaProximoNivel *= 1.5;
    }
  }
}