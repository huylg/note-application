import 'dart:async';

import 'bloc_provider.dart';
import 'package:note_application/dao/note_dao.dart';
import 'package:note_application/models/note.dart';

class NoteBloc implements BlocBase{

	final _notesController = StreamController<List<Note>>.broadcast();

	StreamSink<List<Note>> get _inNotes => _notesController.sink;

	Stream<List<Note>> get notes => _notesController.stream;


	final _addNoteController = StreamController<Note>.broadcast();

	StreamSink<Note> gen inAddNote => _addNoteController.sink();


	NoteBloc(){
		getNotes();

		_addNoteController.stream.listen(_handleAddNote);
	}
	
	@override
	void dispose(){
		_notesController.close();
		_addNoteController.close();
	}

	void getNotes() async {
		List<Note> notes = await DatabaseProvider
	}

}
