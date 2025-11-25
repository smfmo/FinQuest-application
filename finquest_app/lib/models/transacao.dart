class Transacao {
  final String id;
  final String titulo;
  final double valor;
  final DateTime data;
  final String categoria;
  final String? descricao;

  Transacao({
    required this.id,
    required this.titulo,
    required this.valor,
    required this.data,
    required this.categoria,
    this.descricao,
  });

  // --- NOVO: Converte um Mapa (do banco) para uma Transacao (do app) ---
  factory Transacao.fromMap(Map<String, dynamic> map) {
    return Transacao(
      id: map['id'],
      titulo: map['titulo'],
      valor: map['valor'],
      // O banco salva data como texto (String), precisamos converter de volta
      data: DateTime.parse(map['data']),
      categoria: map['categoria'],
      descricao: map['descricao'],
    );
  }

  // --- NOVO: Converte uma Transacao (do app) para um Mapa (pro banco) ---
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'valor': valor,
      'data': data.toIso8601String(), // Salva data como texto ISO8601
      'categoria': categoria,
      'descricao': descricao,
    };
  }
}