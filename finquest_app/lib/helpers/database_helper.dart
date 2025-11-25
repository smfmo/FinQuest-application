import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/transacao.dart';
import '../models/meta.dart'; // Importe o modelo Meta

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'finquest_v2.db'); // Mudei o nome para forçar criação nova

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Tabela Transações
    await db.execute('''
      CREATE TABLE transacoes(
        id TEXT PRIMARY KEY,
        titulo TEXT,
        valor REAL,
        data TEXT,
        categoria TEXT,
        descricao TEXT
      )
    ''');

    // --- NOVO: Tabela Metas ---
    await db.execute('''
      CREATE TABLE metas(
        id TEXT PRIMARY KEY,
        titulo TEXT,
        valorAtual REAL,
        valorMeta REAL,
        prazo TEXT,
        concluida INTEGER
      )
    ''');
  }

  // --- TRANSAÇÕES ---
  Future<void> insertTransacao(Transacao transacao) async {
    final db = await database;
    await db.insert('transacoes', transacao.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Transacao>> getTransacoes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('transacoes');
    return List.generate(maps.length, (i) => Transacao.fromMap(maps[i]));
  }

  Future<void> deleteTransacao(String id) async {
    final db = await database;
    await db.delete('transacoes', where: 'id = ?', whereArgs: [id]);
  }

  // --- NOVAS FUNÇÕES: METAS ---
  Future<void> insertMeta(Meta meta) async {
    final db = await database;
    await db.insert('metas', meta.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Meta>> getMetas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('metas');
    return List.generate(maps.length, (i) => Meta.fromMap(maps[i]));
  }

  Future<void> deleteMeta(String id) async {
    final db = await database;
    await db.delete('metas', where: 'id = ?', whereArgs: [id]);
  }

  // Atualizar meta (ex: mudar valor atual ou marcar como concluída)
  Future<void> updateMeta(Meta meta) async {
    final db = await database;
    await db.update(
      'metas',
      meta.toMap(),
      where: 'id = ?',
      whereArgs: [meta.id],
    );
  }
}