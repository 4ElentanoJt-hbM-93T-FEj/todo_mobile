import 'package:sqflite/sqflite.dart';

class DatabaseCore {
  DatabaseCore._();
  static final DatabaseCore instance = DatabaseCore._();
  
  static const String _dbName = 'my_db.db';
  static const int _dbVersion = 1;
  
  Database? _database;
  
  Future<Database> get database async {
    if (_database != null && _database!.isOpen) {
      return _database!;
    }
    return await initDatabase();
  }
  
  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = '$databasesPath/$_dbName';
    
    _database = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    
    return _database!;
  }
  
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE User (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        password_hash TEXT NOT NULL,
        created_at INTEGER NOT NULL
      )
    ''');
    
    await db.execute('''
      CREATE TABLE Tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        description TEXT,
        created_at INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES User (id)
      )
    ''');
    
    // await db.execute('CREATE INDEX idx_tasks_user_id ON Tasks(user_id)');
  }
  
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Логика обновления схемы базы
  }
  
  Future<void> close() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
    }
    _database = null;
  }
}