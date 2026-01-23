import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/test_result.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // ================= CREATE TABLE =================
  Future _createDB(Database db, int version) async {
    // 🔹 table เดิม (ยังเก็บไว้)
    await db.execute('''
      CREATE TABLE data (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        detail TEXT
      )
    ''');

    // 🔹 table ใหม่: test_results
    await db.execute('''
      CREATE TABLE test_results (
        localId INTEGER PRIMARY KEY AUTOINCREMENT,
        id TEXT,
        userId TEXT,
        leftEyeResult TEXT,
        rightEyeResult TEXT,
        isRisk INTEGER,
        testDate TEXT,
        timestamp INTEGER,
        isDeleted INTEGER
      )
    ''');
  }

  // =================================================
  // ================= CRUD: data ====================
  // =================================================

  Future<int> insert(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('data', row);
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    final db = await instance.database;
    return await db.query('data');
  }

  Future<int> update(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.update(
      'data',
      row,
      where: 'id = ?',
      whereArgs: [row['id']],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'data',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // =================================================
  // ============ CRUD: test_results =================
  // =================================================

  // ➕ Insert ผลตรวจ
  Future<int> insertTestResult(TestResult result) async {
    final db = await instance.database;
    return await db.insert('test_results', result.toSqlite());
  }

  // 📥 ดึงประวัติ (ไม่เอาที่ลบ)
  Future<List<TestResult>> getTestResults() async {
    final db = await instance.database;
    final maps = await db.query(
      'test_results',
      where: 'isDeleted = 0',
      orderBy: 'timestamp DESC',
    );

    return maps.map((e) => TestResult.fromSqlite(e)).toList();
  }

  // 🗑 Soft delete
  Future<int> softDeleteTestResult(int localId) async {
    final db = await instance.database;
    return await db.update(
      'test_results',
      {'isDeleted': 1},
      where: 'localId = ?',
      whereArgs: [localId],
    );
  }
}
