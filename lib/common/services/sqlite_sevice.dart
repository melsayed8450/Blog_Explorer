import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {
 static Future<Database> initializeDB() async {
  // try {
  //   final databasesPath = await getDatabasesPath();
  //   final path = join(databasesPath, 'database.db'); // Replace with your database name
  //   await deleteDatabase(path);
  //   print('Database deleted.');
  // } catch (error) {
  //   print('Error deleting database: $error');
  // }
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE blogs(id TEXT PRIMARY KEY, title TEXT, image_url TEXT)',
        );
      },
      version: 1,
    );
  }

}
