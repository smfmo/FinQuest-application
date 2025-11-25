class Meta {
  final String id;
  final String titulo;
  final double valorAtual; // Quanto já guardou
  final double valorMeta;  // Quanto quer alcançar
  final String prazo;      // Data limite
  final int concluida;     // 0 = Não, 1 = Sim (SQLite não tem boolean)

  Meta({
    required this.id,
    required this.titulo,
    required this.valorAtual,
    required this.valorMeta,
    required this.prazo,
    this.concluida = 0,
  });

  // Calcula o progresso (0.0 a 1.0)
  double get progresso {
    if (valorMeta == 0) return 0.0;
    double p = valorAtual / valorMeta;
    return p > 1.0 ? 1.0 : p; // Não deixa passar de 100%
  }

  factory Meta.fromMap(Map<String, dynamic> map) {
    return Meta(
      id: map['id'],
      titulo: map['titulo'],
      valorAtual: map['valorAtual'],
      valorMeta: map['valorMeta'],
      prazo: map['prazo'],
      concluida: map['concluida'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'valorAtual': valorAtual,
      'valorMeta': valorMeta,
      'prazo': prazo,
      'concluida': concluida,
    };
  }
}