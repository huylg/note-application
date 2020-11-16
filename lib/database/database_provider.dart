import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseProvider {
 	
	DatabaseProvider._();

	static final DatabaseProvider instance = DatabaseProvider._();

	Database _database;

	Future<Database> get database async {

		if(_database != null){
			return _database;
		}

		_database = await initDatabase();
		return _database;
	}

	Future<Database> initDatabase() async {

		Directory documentDirectory = await getApplicationDocumentsDirectory();

		String path = join(documentDirectory.path, 'note.db');

		return await openDatabase(path, version: 1, onCreate: (Database database, int version)async{
			await database.execute('''
					CREATE TABLE note (
							id INTEGER PRIMARY KEY AUTOINCREMENT,
							content TEXT NOT NULL
					)
					''');
		});
	}
}
