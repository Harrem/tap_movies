import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tap_movies/model/movie_model.dart';

class SqliteHelper extends GetxService {
  Database? database;

  @override
  void onInit() {
    super.onInit();
    initDatabase();
  }

  Future<void> initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'my_database.db');

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE watchList(
            id INTEGER PRIMARY KEY,
            title TEXT,
            posterPath TEXT,
            releaseDate TEXT,
            rating REAL
          )
        ''');
      },
    );
  }

  Future<void> addToWatchList(MovieModel movie) async {
    await database!.insert('watchList', movie.toJson());
  }

  Future<List<MovieModel>> getWatchList() async {
    final list = await database!.query('watchList');
    return list.map((json) => MovieModel.fromJson(json)).toList();
  }

  Future<void> removeFromWatchList(int id) async {
    await database!.delete('watchList', where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> isMovieInWatchList(int id) async {
    final List<Map<String, dynamic>> list = await database!.query(
      'watchList',
      where: 'id = ?',
      whereArgs: [id],
    );
    return list.isNotEmpty;
  }
}
