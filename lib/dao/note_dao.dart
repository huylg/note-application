import 'dart:async';
import 'package:note_application/models/note.dart';
import 'package:note_application/database/database_provider.dart';
class NoteDAO{

	Future<List<Note>> get() async{

		final db = await DatabaseProvider.instance.database;

		var res = await db.query('note');

		List<Note> notes = List.generate(res.length, (i) => Note.fromJson(res[i]));

		return notes;
	}

	Future<Note> getWithId(int id) async {
		final db = await DatabaseProvider.instance.database;

		var res = await db.query('note',where: 'id = ?', whereArgs: [id]);

		return res.isEmpty ? null : Note.fromJson(res.first);
	}

	Future<int> post(Note note) async {

		final db = await DatabaseProvider.instance.database;

		var res = await db.insert('note',note.toJson());

		return res;

	}

	Future<int> put(Note note) async {
		final db = await DatabaseProvider.instance.database;
		var res = await db.update('note',note.toJson(), where: 'id = ?', whereArgs: [note.id]);

		return res;
	}
	

	Future<int> delete(int id) async{
		final db =  await DatabaseProvider.instance.database;

		var res = await db.delete('note',where: 'id = ?', whereArgs: [id]);

		return res;
	}

}
