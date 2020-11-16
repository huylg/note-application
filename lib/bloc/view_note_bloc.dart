import 'dart:async';
import 'package:note_application/bloc/bloc_provider.dart';
import 'package:note_application/models/note.dart';
import 'package:note_application/dao/note_dao.dart';

class ViewNoteBloc implements BlocBase{

    final _saveNoteController = StreamController<Note>.broadcast();
    StreamSink<Note> get inSaveNote => _saveNoteController.sink;

    final _deleteNoteController = StreamController<int>.broadcast();
    StreamSink<int> get inDeleteNote => _deleteNoteController.sink;
    

    final _noteSavedController = StreamController<bool>.broadcast();
    StreamSink<bool> get insaved => _noteSavedController.sink;
    Stream<bool> get saved => _noteSavedController.stream;

    final _noteDeletedController = StreamController<bool>.broadcast();
    StreamSink<bool> get indeleted => _noteDeletedController.sink;
    Stream<bool> get deleted => _noteDeletedController.stream;

    ViewNoteBloc(){
        _saveNoteController.stream.listen(_handleSaveNote);
        _deleteNoteController.stream.listen(_handleDeleteNote);
    }

    @override
    void dispose(){
        _saveNoteController.close();
        _deleteNoteController.close();
    }


    void _handleSaveNote(Note note) async {
        final dao = NoteDAO();
        await dao.put(note);

        insaved.add(true);
    }

    void _handleDeleteNote(int id) async{
        final dao = NoteDAO();
        await dao.delete(id);
        
        indeleted.add(true);
    }


}

