import 'package:flutter/material.dart';
import '../models/meta.dart';
import '../helpers/database_helper.dart';

class MetasRepository {
  static List<Meta> _listaMetas = [];

  static List<Meta> get lista => List.unmodifiable(_listaMetas);

  // --- NOVO: Lógica para pegar a Meta Prioritária (Mais próxima do vencimento) ---
  static Meta? get metaPrioritaria {
    if (_listaMetas.isEmpty) return null;

    // 1. Filtra apenas metas não concluídas
    final metasAbertas = _listaMetas.where((m) => m.concluida == 0).toList();

    if (metasAbertas.isEmpty) return null;

    // 2. Ordena pela data (assumindo formato DD/MM/AAAA)
    // Como o banco salva String, precisamos converter para comparar
    metasAbertas.sort((a, b) {
      DateTime dataA = _converterData(a.prazo);
      DateTime dataB = _converterData(b.prazo);
      return dataA.compareTo(dataB); // Do mais cedo para o mais tarde
    });

    // 3. Retorna a primeira da lista (a mais urgente)
    return metasAbertas.first;
  }

  // Função auxiliar para converter "DD/MM/AAAA" em DateTime
  static DateTime _converterData(String dataString) {
    try {
      final parts = dataString.split('/');
      if (parts.length == 3) {
        return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
      }
    } catch (e) {
      // Se der erro, retorna uma data muito distante
      return DateTime(2100);
    }
    return DateTime(2100);
  }
  // ---------------------------------------------------------------------------

  static Future<void> carregarMetas() async {
    final metasDoBanco = await DatabaseHelper().getMetas();
    _listaMetas = metasDoBanco;
  }

  static Future<void> adicionar(Meta meta) async {
    await DatabaseHelper().insertMeta(meta);
    _listaMetas.add(meta);
  }

  static Future<void> remover(String id) async {
    await DatabaseHelper().deleteMeta(id);
    _listaMetas.removeWhere((m) => m.id == id);
  }

  static Future<void> atualizar(Meta meta) async {
    await DatabaseHelper().updateMeta(meta);
    int index = _listaMetas.indexWhere((m) => m.id == meta.id);
    if (index != -1) {
      _listaMetas[index] = meta;
    }
  }
}