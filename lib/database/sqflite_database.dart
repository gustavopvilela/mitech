import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BookmarkedPosts {
  static const bookmarkedPostsTable = 'bookmarkedposts';

  // Construtor com acesso privado
  BookmarkedPosts._();

  // Instância de database
  static final BookmarkedPosts instance = BookmarkedPosts._();

  // Instância do SQLite
  static Database? _database;

  get database async {
    if (_database != null) {
      return _database;
    }
    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'bookmarkedposts.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, version) async {
    await db.execute(_bookmarkedPosts);
  }

  String get _bookmarkedPosts => '''
    CREATE TABLE IF NOT EXISTS $bookmarkedPostsTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      subtitle TEXT,
      imageUrl TEXT,
      link TEXT
    )
  ''';

  Future<int> insert(Map<String, dynamic> row, String table) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

// Todas as linhas são retornadas como uma lista de mapas, onde cada mapa é
// uma lista de valores-chave de colunas.
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> querySQL(String sql) async {
    Database db = await instance.database;
    return await db.rawQuery(sql);
  }

  Future<void> executeSQL(String sql) async {
    Database db = await instance.database;
    return await db.execute(sql);
  }

// Todos os métodos : inserir, consultar, atualizar e excluir, também podem ser feitos usando
// comandos SQL brutos. Esse método usa uma consulta bruta para fornecer a contagem de linhas.
  Future<int?> queryRowCount(String table) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

// Assumimos aqui que a coluna id no mapa está definida. Os outros
// valores das colunas serão usados para atualizar a linha.
  Future<int> update(Map<String, dynamic> row, String table) async {
    Database db = await instance.database;
    int id = row["id"];
    return await db.update(table, row, where: 'id = ?', whereArgs: [id]);
  }

// Exclui a linha especificada pelo id. O número de linhas afetadas é
// retornada. Isso deve ser igual a 1, contanto que a linha exista.
  Future<int> delete(int id, String table) async {
    Database db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}